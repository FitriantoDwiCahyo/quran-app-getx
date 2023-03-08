import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/app/constant/theme_app.dart';

import '../home/controllers/home_controller.dart';

class PageTiga extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: c.getBookmark(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                  height: 150,
                  width: 150,
                  'assets/lottie/book_dua.json',
                ),
              );
            }

            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Bookmark belum tersedia'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> dataBookmark = snapshot.data![index];
                return ListTile(
                  onTap: (() {
                    print(dataBookmark);
                  }),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: const AssetImage(
                      'assets/image/border_number.png',
                    ),
                    child: Text(
                      '${index + 1}',
                      style: Get.textTheme.headline3,
                    ),
                  ),
                  title: Text(
                    dataBookmark['surah'].toString().replaceAll("+", "'"),
                    style: Get.textTheme.headline3,
                  ),
                  subtitle: Text(
                    'Ayat ${dataBookmark['ayat']} | Via ${dataBookmark['via']}',
                    style: Get.textTheme.caption,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      c.deleteBookmark(dataBookmark['id']);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: purple,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
