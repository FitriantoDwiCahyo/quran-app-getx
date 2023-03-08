import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/app/modules/home/controllers/home_controller.dart';

import '../../constant/theme_app.dart';
import '../../data/models/juz_model.dart' as juz;
import '../../data/models/surah_model.dart';
import '../../routes/app_pages.dart';

class PageDua extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<juz.Juz>?>(
      future: controller.getJuzProvider(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset(
                height: 150, width: 150, 'assets/lottie/book_dua.json'),
          );
        }
        // print(snapshot.data);
        if (!snapshot.hasData) {
          return const Center(
            child: Text('Data Empthy'),
          );
        }
        return ListView.separated(
          itemCount: snapshot.data?.length as int,
          itemBuilder: (context, index) {
            juz.Juz allJuz = snapshot.data![index];

            //logic untuk selection surah sesuai jumlah surah di juz
            List<Surah> rawAllSurahInJuz = [];
            List<Surah> allSurahInJuz = [];

            for (Surah item in controller.allSurah) {
              rawAllSurahInJuz.add(item);
              if (item.number == allJuz.juzEndSurahNumber) {
                break;
              }
            }

            for (Surah item in rawAllSurahInJuz.reversed.toList()) {
              allSurahInJuz.add(item);
              if (item.number == allJuz.juzStartSurahNumber) {
                break;
              }
            }
            return ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                  'juz': allJuz,
                  'surah': allSurahInJuz.reversed.toList(),
                });
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage(
                  'assets/image/border_number.png',
                ),
                child: Center(
                  child: Text(
                    '${allJuz.juz}',
                    style: Get.textTheme.headline3,
                  ),
                ),
              ),
              title: Text('Juz ${allJuz.juz}', style: Get.textTheme.headline3),
              isThreeLine: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Mulai dari ${allJuz.juzStartInfo} surah ke - ${allJuz.juzStartSurahNumber}',
                      style: Get.textTheme.caption),
                  Text(
                      'Sampai ${allJuz.juzEndInfo} surah ke - ${allJuz.juzEndSurahNumber}',
                      style: Get.textTheme.caption),
                ],
              ),
              // trailing: Text(
              //   '${surah.name?.short}',
              //   style: const TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: purpleLight,
              //   ),
              // ),
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey[200],
            ),
          ),
        );
      },
    );
  }
}
