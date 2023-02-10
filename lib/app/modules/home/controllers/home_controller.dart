import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/app/data/models/surah_model.dart';
import 'package:quran_app/app/data/providers/surah_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/detail_surah_model.dart';
import '../../../data/providers/detail_surah_provider.dart';

class HomeController extends GetxController {
  SurahProvider surahProv = SurahProvider();

  RxBool isLightTheme = false.obs;

  Future<List<Surah>> getSurahProvider() async {
    return await surahProv.getSurah();
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
