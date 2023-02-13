import 'package:get/get.dart';

import '../models/surah_model.dart';

class SurahProvider extends GetConnect {
  // @override
  // void onInit() {
  //   httpClient.defaultDecoder = (map) {
  //     if (map is Map<String, dynamic>) return Surah.fromJson(map);
  //     if (map is List) return map.map((item) => Surah.fromJson(item)).toList();
  //   };
  //   httpClient.baseUrl = 'https://api.quran.gading.dev/surah';
  // }

  Future<List<Surah>> getSurah() async {
    final response = await get('https://api.quran.gading.dev/surah/');
    return Surah.fromJsonList(response.body['data']);
  }

  // Future<Response<Surah>> postSurah(Surah surah) async =>
  //     await post('surah', surah);
  // Future<Response> deleteSurah(int id) async => await delete('surah/$id');
}
