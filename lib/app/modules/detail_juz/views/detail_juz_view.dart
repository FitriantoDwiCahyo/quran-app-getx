import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constant/theme_app.dart';
import '../../../data/models/juz_model.dart' as juz;
import '../../../data/models/surah_model.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz versesByJuz = Get.arguments['juz'];
  final List<Surah> versesBySurah = Get.arguments['surah'];
  @override
  Widget build(BuildContext context) {
    versesBySurah.forEach(
      (element) => print(element.name!.transliteration!.id),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Juz ${versesByJuz.juz}',
          style: Get.textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: versesByJuz.verses?.length ?? 0,
            itemBuilder: (context, index) {
              // print(index);
              if (versesByJuz.verses?.length == null) {
                return const Center(
                  child: Text('Empthy'),
                );
              }

              juz.Verses ayat = versesByJuz.verses![index];

              print(controller.index);

              if (index != 0) {
                if (ayat.number?.inSurah == 1) {
                  controller.index++;
                }
              }

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (ayat.number?.inSurah == 1) ...[
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
                          // middleText: '${versesByJuz[] ?? 'Tafsir Empty'}',
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
                                      '${versesBySurah[controller.index].name?.transliteration?.id}',
                                      style: Get.textTheme.bodyText2,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${versesBySurah[controller.index].name?.translation?.id}',
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
                                          '${versesBySurah[controller.index].revelation?.id?.toUpperCase()}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Container(
                                          height: 4,
                                          width: 4,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        Text(
                                          '${versesBySurah[controller.index].numberOfVerses} Ayat',
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
                                    // if (versesBySurah[controller.index].preBismillah?.text.arab ==
                                    //     null) ...[
                                    //   Text('')
                                    // ] else ...[
                                    //   Image.asset(
                                    //       height: 48,
                                    //       width: 214,
                                    //       'assets/image/bismillah.png'),
                                    // ]
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
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                                    height: 37,
                                    width: 37,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/image/border_number.png',
                                        ),
                                      ),
                                      // borderRadius: BorderRadius.circular(50),
                                      // color: purpleLight,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${ayat.number?.inSurah}',
                                        style: Get.textTheme.bodyText1,
                                      ),
                                    ),
                                  ),
                                  GetBuilder<DetailJuzController>(
                                    init: DetailJuzController(),
                                    initState: (_) {
                                      ayat.audioStatus = 'stop';
                                    },
                                    builder: (c) {
                                      return Row(
                                        children: [
                                          (ayat.audioStatus == 'stop')
                                              ? IconButton(
                                                  onPressed: () {
                                                    c.playAudio(ayat);
                                                  },
                                                  icon: const Icon(
                                                    Icons.play_arrow,
                                                    color: purpleLight,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    (ayat.audioStatus ==
                                                            'playing')
                                                        ? IconButton(
                                                            onPressed: () {
                                                              c.pauseAudio(
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
                                                              c.resumeAudio(
                                                                  ayat);
                                                            },
                                                            icon: const Icon(
                                                              Icons.play_arrow,
                                                              color:
                                                                  purpleLight,
                                                            ),
                                                          ),
                                                    IconButton(
                                                      onPressed: () {
                                                        c.stopAudio(ayat);
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
                                                    onPressed: () {
                                                      c.addBookmark(
                                                          true,
                                                          versesBySurah[
                                                              controller.index],
                                                          ayat,
                                                          index);
                                                    },
                                                    child: const Text(
                                                      'Last Read',
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      c.addBookmark(
                                                          false,
                                                          versesBySurah[
                                                              controller.index],
                                                          ayat,
                                                          index);
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
                              '${ayat.text?.arab}',
                              textAlign: TextAlign.end,
                              style: Get.textTheme.headline4,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              '${ayat.translation?.id}',
                              textAlign: TextAlign.justify,
                              style: Get.textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                                    height: 37,
                                    width: 37,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/image/border_number.png',
                                        ),
                                      ),
                                      // borderRadius: BorderRadius.circular(50),
                                      // color: purpleLight,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${ayat.number?.inSurah}',
                                        style: Get.textTheme.bodyText1,
                                      ),
                                    ),
                                  ),
                                  GetBuilder<DetailJuzController>(
                                    init: DetailJuzController(),
                                    initState: (_) {
                                      ayat.audioStatus = 'stop';
                                    },
                                    builder: (c) {
                                      return Row(
                                        children: [
                                          (ayat.audioStatus == 'stop')
                                              ? IconButton(
                                                  onPressed: () {
                                                    c.playAudio(ayat);
                                                  },
                                                  icon: const Icon(
                                                    Icons.play_arrow,
                                                    color: purpleLight,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    (ayat.audioStatus ==
                                                            'playing')
                                                        ? IconButton(
                                                            onPressed: () {
                                                              c.pauseAudio(
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
                                                              c.resumeAudio(
                                                                  ayat);
                                                            },
                                                            icon: const Icon(
                                                              Icons.play_arrow,
                                                              color:
                                                                  purpleLight,
                                                            ),
                                                          ),
                                                    IconButton(
                                                      onPressed: () {
                                                        c.stopAudio(ayat);
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
                                                    onPressed: () {
                                                      c.addBookmark(
                                                          true,
                                                          versesBySurah[
                                                              controller.index],
                                                          ayat,
                                                          index);
                                                    },
                                                    child: const Text(
                                                      'Last Read',
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      c.addBookmark(
                                                          false,
                                                          versesBySurah[1],
                                                          ayat,
                                                          index);
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
                              '${ayat.text?.arab}',
                              textAlign: TextAlign.end,
                              style: Get.textTheme.headline4,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              '${ayat.translation?.id}',
                              textAlign: TextAlign.justify,
                              style: Get.textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
