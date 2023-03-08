import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/app/modules/home/controllers/home_controller.dart';

import '../../../constant/theme_app.dart';
import '../../../data/models/detail_surah_model.dart' as detailSurah;
import '../../../data/models/surah_model.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  Surah surah = Get.arguments;
  final homeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${surah.name?.transliteration?.id}',
            style: Get.textTheme.headline2),
        centerTitle: true,
      ),
      body: FutureBuilder<detailSurah.DetailSurah?>(
          future: controller.getDetail(surah.number.toString()),
          builder: (context, snapshot) {
            detailSurah.DetailSurah? detailSurahAl = snapshot.data;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                    height: 100, width: 100, 'assets/lottie/book_dua.json'),
              );
            }

            if (snapshot.connectionState == ConnectionState.none) {
              return const ScaffoldMessenger(
                child: SnackBar(
                  content: Text('No Connection'),
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('Empty Data'));
            }

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
              children: [
                GestureDetector(
                  onTap: () => Get.defaultDialog(
                    backgroundColor: Get.isDarkMode
                        ? purpleDark.withOpacity(0.1)
                        : purpleLight.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    title: 'Tafsir',
                    titleStyle: const TextStyle(fontSize: 24),
                    middleText: '${surah.tafsir?.id ?? 'Tafsir Empty'}',
                    middleTextStyle: const TextStyle(
                      fontSize: 16,
                      wordSpacing: 3,
                    ),
                  ),
                  child: Container(
                    // padding:
                    //     const EdgeInsets.symmetric(vertical: 24, horizontal: 54),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        // stops: [0.5, 0.4],
                        colors: [purple1, purple2],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: -10,
                          child: Opacity(
                            opacity: 0.1,
                            child: Container(
                              height: 198,
                              width: 324,
                              child: Image.asset(
                                'assets/image/quran.png',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 54,
                            vertical: 24,
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${detailSurahAl?.name?.transliteration.id}',
                                style: Get.textTheme.bodyText2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${detailSurahAl?.name?.translation.id}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Divider(
                                color: white,
                                indent: 40,
                                endIndent: 40,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '${detailSurahAl?.revelation?.id.toUpperCase()}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Container(
                                    height: 4,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(50),
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
                              const SizedBox(height: 32),
                              // Text(
                              //   detailSurahAl?.preBismillah?.text.arab == null
                              //       ? ''
                              //       : ,
                              //   style: TextStyle(fontSize: 24),
                              // ),
                              if (detailSurahAl?.preBismillah?.text.arab ==
                                  null) ...[
                                Text('')
                              ] else ...[
                                Image.asset(
                                    height: 48,
                                    width: 214,
                                    'assets/image/bismillah.png'),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: detailSurahAl?.verses?.length as int,
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[200],
                      indent: 4,
                      endIndent: 4,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    // print(index);
                    detailSurah.Verse ayat = detailSurahAl!.verses![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Get.isDarkMode
                              ? cardLight
                              : cardDark.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: purpleLight),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: Get.textTheme.bodyText1,
                                        ),
                                      ),
                                    ),
                                    GetBuilder<DetailSurahController>(
                                      init: DetailSurahController(),
                                      initState: (_) {},
                                      builder: (c) {
                                        return Row(
                                          children: [
                                            (ayat.audioSelected == 'stop')
                                                ? IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .playAudio(ayat);
                                                    },
                                                    icon: const Icon(
                                                      Icons.play_arrow,
                                                      color: purpleLight,
                                                    ),
                                                  )
                                                : Row(
                                                    children: [
                                                      (ayat.audioSelected ==
                                                              'playing')
                                                          ? IconButton(
                                                              onPressed: () {
                                                                controller
                                                                    .pauseAudio(
                                                                        ayat);
                                                              },
                                                              icon: const Icon(
                                                                Icons.pause,
                                                                color:
                                                                    purpleLight,
                                                              ),
                                                            )
                                                          : IconButton(
                                                              onPressed: () {
                                                                controller
                                                                    .resumeAudio(
                                                                        ayat);
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                color:
                                                                    purpleLight,
                                                              ),
                                                            ),
                                                      IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .stopAudio(ayat);
                                                        },
                                                        icon: const Icon(
                                                          Icons.stop,
                                                          color: purpleLight,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            IconButton(
                                              onPressed: () {
                                                Get.defaultDialog(
                                                  title: 'Bookmark',
                                                  middleText:
                                                      'Pilih jenis bookmark',
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () async{
                                                        await controller.addBookmark(
                                                          true,
                                                          snapshot.data!,
                                                          ayat,
                                                          index,
                                                        );
                                                        homeC.update();
                                                      },
                                                      child: const Text(
                                                        'Last Read',
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        controller.addBookmark(
                                                          false,
                                                          snapshot.data!,
                                                          ayat,
                                                          index,
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Bookmark',
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.bookmark_border,
                                                color: purpleLight,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${ayat.text.arab}',
                                textAlign: TextAlign.end,
                                style: Get.textTheme.headline4,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                '${ayat.translation.id}',
                                textAlign: TextAlign.justify,
                                style: Get.textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            );
          }),
    );
  }
}
