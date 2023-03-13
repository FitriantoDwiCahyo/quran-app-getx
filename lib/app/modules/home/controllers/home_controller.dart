import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/app/constant/theme_app.dart';
import 'package:quran_app/app/data/db/bookmark.dart';
import 'package:quran_app/app/data/models/surah_model.dart';
import 'package:quran_app/app/data/providers/juz_provider.dart';
import 'package:quran_app/app/data/providers/surah_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/models/juz_model.dart';

// import '../../../data/models/detail_surah_model.dart';
// import '../../../data/providers/detail_surah_provider.dart';

class HomeController extends GetxController {
  SurahProvider surahProv = SurahProvider();
  JuzProvider juzProv = JuzProvider();

  List<Surah> allSurah = [];

  DatabaseManager database = DatabaseManager.instance;

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmark =
        await db.query('bookmark', where: 'last_read = 0');

    return allBookmark;
  }

  Future<List<Surah>> getSurahProvider() async {
    allSurah = await surahProv.getSurah();
    return allSurah;
  }

  Future<List<Juz>> getJuzProvider() async {
    return await juzProv.getJuz();
  }

  void deleteBookmark(int id) async {
    Database db = await database.db;
    await db.delete('bookmark', where: 'id == $id');
    update();
    Get.snackbar('Success', 'Bookmark telah terhapus');
  }

  Future<Map<String, dynamic>?> getLastRead() async {
    Database db = await database.db;
    List<Map<String, dynamic>> dataLastRead = await db.query(
      'bookmark',
      where: 'last_read = 1',
      orderBy: 'surah',
    );

    if (dataLastRead.isEmpty) {
      return null;
    } else {
      return dataLastRead.first;
    }
  }

  void deleteLastRead(int id) async {
    Database db = await database.db;
    await db.delete('bookmark', where: 'id = $id');
    update();
    Get.back(); //utk tutup getdialog
    Get.snackbar('Success', 'Last read berhasil dihapus', colorText: white);
  }

  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // saveThemStatus() async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.setBool('theme', isLightTheme.value);
  // }

  // getThemeStatus() async {
  //   var _isLight = _prefs.then((SharedPreferences prefs) {
  //     return prefs.getBool('theme') != null ? prefs.getBool('theme') : true;
  //   }).obs;

  //   isLightTheme.value = await _isLight.value as bool;

  //   Get.changeThemeMode(isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  // }
}
