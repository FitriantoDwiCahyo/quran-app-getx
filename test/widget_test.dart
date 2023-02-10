// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/app/data/models/detail_surah_model.dart';
import 'package:quran_app/app/data/models/surah_model.dart';

import 'package:quran_app/main.dart';

import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse('https://api.quran.gading.dev/surah');

  final response = await http.get(url);

  List dataAnnas = (json.decode(response.body) as Map<String, dynamic>)['data'];

  Surah annas = Surah.fromJson(dataAnnas[113]);

  Uri urlDetail =
      Uri.parse('https://api.quran.gading.dev/surah/${annas.number}');

  final responseDetail = await http.get(urlDetail);

  Map<String, dynamic> detailAnnas =
      (json.decode(responseDetail.body) as Map<String, dynamic>)['data'];

  // print(detailAnnas);

  DetailSurah detailSurah = DetailSurah.fromJson(detailAnnas);

  print(response.body);
}
