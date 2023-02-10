import 'package:get/get.dart';

import '../models/detail_surah_model.dart';

class DetailSurahProvider extends GetConnect {
  // @override
  // void onInit() {
  //   httpClient.defaultDecoder = (map) {
  //     if (map is Map<String, dynamic>) return DetailSurah.fromJson(map);
  //     if (map is List)
  //       return map.map((item) => DetailSurah.fromJson(item)).toList();
  //   };
  //   httpClient.baseUrl = 'https://api.quran.gading.dev/surah';
  // }

  Future<DetailSurah?> getDetailSurah(String id) async {
    final response = await get('https://api.quran.gading.dev/surah/$id');
    return DetailSurah.fromJson(response.body['data']);
  }

  // Future<Response<DetailSurah>> postDetailSurah(
  //         DetailSurah detailsurah) async =>
  //     await post('detailsurah', detailsurah);
  // Future<Response> deleteDetailSurah(int id) async =>
  //     await delete('detailsurah/$id');
}
