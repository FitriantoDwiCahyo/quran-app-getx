import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/app/modules/home/controllers/home_controller.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constant/theme_app.dart';
import '../../../data/db/bookmark.dart';
import '../../../data/models/juz_model.dart';
import '../../../data/models/surah_model.dart';

class DetailJuzController extends GetxController {
  int index = 0;

  final player = AudioPlayer();


  Verses? lastVerse;

  DatabaseManager database = DatabaseManager.instance;

  void addBookmark(
      bool lastRead, Surah surah, Verses ayat, int indexAyat) async {
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete('bookmark', where: 'last_read = 1');
    } else {
      List checkData = await db.query('bookmark',
          columns: ['surah', 'ayat', 'juz', 'via', 'index_ayat', 'last_read'],
          where:
              "surah = '${surah.name?.transliteration?.id?.replaceAll("'", "+")}' and ayat = ${ayat.number!.inSurah} and juz = ${ayat.meta!.juz} and via = 'juz' and index_ayat = $indexAyat and last_read = 0");

      if (checkData.isNotEmpty) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert('bookmark', {
        'surah': '${surah.name?.transliteration?.id?.replaceAll("'", "+")}',
        'ayat': ayat.number?.inSurah,
        'juz': ayat.meta?.juz,
        'via': 'juz',
        'index_ayat': indexAyat,
        'last_read': lastRead == true ? 1 : 0,
      });

      Get.back(); //tutup dialog
      Get.snackbar('Success', 'Berhasil menambahkan bookmark',
          colorText: white);
    } else {
      Get.back(); //tutup dialog
      Get.snackbar('Something wrong', 'Bookmark sudah tersedia',
          colorText: white);
    }
    var data = await db.query('bookmark');
    print(data);
  }

  void playAudio(Verses? ayat) async {
    if (ayat?.audio!.primary != null) {
      try {
        //kondisi untuk mencegah penumpukan audio ketika di pause dan memulai audio ynag berikutnya
        if (lastVerse == null) {
          lastVerse = ayat;
        }

        lastVerse!.audioStatus = 'stop';
        lastVerse = ayat;
        lastVerse!.audioStatus = 'stop';
        update();

        await player.stop();
        await player.setUrl(ayat!.audio!.primary.toString());
        ayat.audioStatus = 'playing';
        update();

        await player.play();
        ayat.audioStatus = 'stop';
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

  void pauseAudio(Verses ayat) async {
    try {
      await player.pause();
      ayat.audioStatus = 'pause';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: e.message.toString());
    } catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: 'Tidak dapat pause audio');
    }
  }

  void resumeAudio(Verses ayat) async {
    try {
      ayat.audioStatus = 'playing';
      update();
      await player.play();
      ayat.audioStatus = 'stop';
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: e.message.toString());
    } catch (e) {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: 'Tidak dapat pause audio');
    }
  }

  void stopAudio(Verses ayat) async {
    try {
      await player.stop();
      ayat.audioStatus = 'stop';
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
