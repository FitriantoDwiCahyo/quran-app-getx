import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/detail_surah_model.dart' as detailSurah;
import '../../../data/models/surah_model.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${surah.name?.transliteration?.id?.toUpperCase()}'),
        centerTitle: true,
      ),
      body: FutureBuilder<detailSurah.DetailSurah?>(
          future: controller.getDetail(surah.number.toString()),
          builder: (context, snapshot) {
            detailSurah.DetailSurah? detailSurahAl = snapshot.data;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Lottie.asset('assets/lottie/loading.json'),);
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('Empty Data'));
            }

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 12),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          '${detailSurahAl?.name?.transliteration.id}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${detailSurahAl?.name?.translation.id}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          indent: 40,
                          endIndent: 40,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${detailSurahAl?.revelation?.id}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${detailSurahAl?.numberOfVerses} Ayat',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                            detailSurahAl?.preBismillah?.text.arab == null
                                ? ''
                                : '${detailSurahAl?.preBismillah?.text.arab}',
                            style: TextStyle(fontSize: 24))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: detailSurahAl?.verses?.length,
                  itemBuilder: (context, index) {
                    detailSurah.Verse ayat = detailSurahAl!.verses![index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(child: Text('${index + 1}')),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.share_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon:
                                          const Icon(Icons.play_arrow_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.bookmark_border),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text('${ayat.text.arab}'),
                            Text(
                              '${ayat.translation.id}',
                              textAlign: TextAlign.justify,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          }),
    );
  }
}
