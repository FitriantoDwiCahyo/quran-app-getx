import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/app/constant/theme_app.dart';
import 'package:quran_app/app/routes/app_pages.dart';

import '../../../data/models/surah_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran App'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamualikum',
                style: Get.textTheme.bodyText1,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Ayo Mulai Membaca',
                style: Get.textTheme.headline6,
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.4, 0.6],
                    colors: [purple1, purple2],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    child: Stack(
                      children: [
                        Container(
                          height: 131,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 19,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/image/book.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Last Read',
                                    style: Get.textTheme.bodyText2,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Al-Fatiah',
                                style: Get.textTheme.subtitle1,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Ayat No. 1',
                                style: Get.textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: -10,
                          child: Image.asset(
                            'assets/image/quran.png',
                            height: 126,
                            width: 206,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TabBar(
                labelStyle: Get.textTheme.subtitle1,
                indicatorColor: purpleLight,
                tabs: const [
                  Tab(
                    text: 'Surah',
                    // child: Text('Surah', style: Get.textTheme.subtitle1),
                  ),
                  Tab(
                    text: 'Juz',
                  ),
                  Tab(
                    text: 'Bookmark',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    //Page 1
                    pageSatu(),
                    const Center(
                      child: Text('Page 2'),
                    ),
                    const Center(
                      child: Text('Page 3'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageSatu() {
    return FutureBuilder<List<Surah>>(
      future: controller.getSurahProvider(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset('assets/lottie/loading.json'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('Data Empthy'),
          );
        }
        print(snapshot.data);
        return ListView.separated(
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
                  style: Get.textTheme.subtitle1,
                ),
              ),
              title: Text('${surah.name?.transliteration?.id}',
                  style: Get.textTheme.subtitle1),
              subtitle: Text(
                  '${surah.numberOfVerses} Ayat | ${surah.revelation?.id}',
                  style: Get.textTheme.subtitle2),
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
          separatorBuilder: (context, index) => const Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          itemCount: snapshot.data!.length,
        );
      },
    );
  }
}
