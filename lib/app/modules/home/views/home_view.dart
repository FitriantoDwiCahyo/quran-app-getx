import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/app/constant/theme_app.dart';
import 'package:quran_app/app/modules/item_tab/page_dua.dart';
import 'package:quran_app/app/modules/item_tab/page_satu.dart';
import 'package:quran_app/app/routes/app_pages.dart';

import '../../../data/models/surah_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quran App',
          style: Get.textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            right: 24,
            left: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamualikum',
                style: Get.textTheme.headline6,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Messi',
                style: Get.textTheme.headline1,
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
                                    style: Get.textTheme.bodyText1,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Al-Fatiah',
                                style: Get.textTheme.bodyText2,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Ayat No. 1',
                                style: Get.textTheme.bodyText1,
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
                // unselectedLabelStyle: TextStyle(color: purpleLight),
                labelColor: Get.isDarkMode ? purple : white,
                unselectedLabelColor: grey,
                labelStyle: Get.textTheme.headline3,
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
                    PageSatu(),
                    PageDua(),
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
}
