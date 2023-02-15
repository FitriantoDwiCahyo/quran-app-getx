import 'package:get/get.dart';

import '../models/juz_model.dart';

class JuzProvider extends GetConnect {
  // @override
  // void onInit() {
  //   httpClient.defaultDecoder = (map) {
  //     if (map is Map<String, dynamic>) return Juz.fromJson(map);
  //     if (map is List) return map.map((item) => Juz.fromJson(item)).toList();
  //   };
  //   httpClient.baseUrl = 'YOUR-API-URL';
  // }

  Future<List<Juz>> getJuz() async {
    List<Juz> allJuz = [];
    for (int i = 1; i <= 30; i++) {
      final response = await get('https://api.quran.gading.dev/juz/$i');

      Juz juz = Juz.fromJson(response.body['data']);

      allJuz.add(juz);
    }
    return allJuz;
  }

  // Future<Response<Juz>> postJuz(Juz juz) async => await post('juz', juz);
  // Future<Response> deleteJuz(int id) async => await delete('juz/$id');
}
