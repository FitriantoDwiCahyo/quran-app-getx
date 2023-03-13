import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/app/constant/theme_app.dart';
import 'package:quran_app/app/data/db/bookmark.dart';
import 'package:quran_app/app/data/models/juz_model.dart';

import 'package:quran_app/app/data/providers/detail_surah_provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/models/detail_surah_model.dart';

class DetailSurahController extends GetxController {
  DetailSurahProvider detailSurahProv = DetailSurahProvider();
  AutoScrollController scrollC = AutoScrollController();
  final player = AudioPlayer();

  Verse? lastVerse;

  DatabaseManager database = DatabaseManager.instance;

  Future<void> addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete('bookmark', where: 'last_read = 1');
    } else {
      List checkData = await db.query('bookmark',
          columns: ['surah','number_surah', 'ayat', 'juz', 'via', 'index_ayat', 'last_read'],
          where:
              "surah = '${surah.name!.transliteration.id.replaceAll("'", "+")}' and number_surah = '${surah.number!}'and ayat = ${ayat.number.inSurah} and juz = ${ayat.meta.juz} and via = 'surah' and index_ayat = $indexAyat and last_read = 0");

      if (checkData.isNotEmpty) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert('bookmark', {
        'surah': '${surah.name?.transliteration.id.replaceAll("'", "+")}',
        'number_surah': surah.number,
        'ayat': ayat.number.inSurah,
        'juz': ayat.meta.juz,
        'via': 'surah',
        'index_ayat': indexAyat,
        'last_read': lastRead == true ? 1 : 0,
      });

      Get.back(); //tutup dialog
      Get.snackbar('Success', 'Berhasil menambahkan bookmark',
          colorText: white,
          duration: Duration(
            seconds: 1,
          ));
    } else {
      Get.back(); //tutup dialog
      Get.snackbar('Something wrong', 'Bookmark sudah tersedia',
          colorText: white);
    }
    var data = await db.query('bookmark');
    print(data);
  }

  Future<DetailSurah?> getDetail(String id) async {
    return await detailSurahProv.getDetailSurah(id);
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio.primary != null) {
      try {
        //kondisi untuk mencegah penumpukan audio ketika di pause dan memulai audio ynag berikutnya
        if (lastVerse == null) {
          lastVerse = ayat;
        }

        lastVerse!.audioSelected = 'stop';
        lastVerse = ayat;
        lastVerse!.audioSelected = 'stop';
        update();

        await player.stop();
        await player.setUrl(ayat!.audio.primary);
        ayat.audioSelected = 'playing';
        update();

        await player.play();
        ayat.audioSelected = 'stop';
        update();

        await player.stop();
      } on PlayerException catch (e) {
        Get.defaultDialog(
            title: 'Terjadi Kesalahan', middleText: e.message.toString());
      } catch (e) {
        Get.defaultDialog(
            title: 'Terjadi Kesalahan',
            middleText: 'Tidak dapat memutar audio');
      }
    } else {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: 'Url Tidak Ada');
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.audioSelected = 'pause';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: e.message.toString());
    } catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: 'Tidak dapat pause audio');
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      ayat.audioSelected = 'playing';
      update();
      await player.play();
      ayat.audioSelected = 'stop';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: e.message.toString());
    } catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: 'Tidak dapat pause audio');
    }
  }

  void stopAudio(Verse ayat) async {
    try {
      await player.stop();
      ayat.audioSelected = 'stop';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: e.message.toString());
    } catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: 'Tidak dapat pause audio');
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
