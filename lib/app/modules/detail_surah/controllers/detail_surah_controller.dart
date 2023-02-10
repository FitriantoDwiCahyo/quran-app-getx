import 'package:get/get.dart';
import 'package:quran_app/app/data/providers/detail_surah_provider.dart';

import '../../../data/models/detail_surah_model.dart';

class DetailSurahController extends GetxController {
  DetailSurahProvider detailSurahProv = DetailSurahProvider();

  Future<DetailSurah?> getDetail(String id) async {
    return await detailSurahProv.getDetailSurah(id);
  }
}
