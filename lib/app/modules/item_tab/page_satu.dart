import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/app/modules/home/controllers/home_controller.dart';

import '../../constant/theme_app.dart';
import '../../data/models/surah_model.dart';
import '../../routes/app_pages.dart';

class PageSatu extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: controller.getSurahProvider(),
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
            Surah surah = snapshot.data![index];
            return ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage(
                  'assets/image/border_number.png',
                ),
                child: Text(
                  '${surah.number}',
                  style: Get.textTheme.headline3,
                ),
              ),
              title: Text('${surah.name?.transliteration?.id}',
                  style: Get.textTheme.headline3),
              subtitle: Text(
                  '${surah.numberOfVerses} Ayat | ${surah.revelation?.id}',
                  style: Get.textTheme.caption),
              trailing: Text(
                '${surah.name?.short}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: purpleLight,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
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