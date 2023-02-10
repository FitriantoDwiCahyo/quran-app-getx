import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quran App',
              style: Get.textTheme.headline5,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Learn Quran and\n Recite once everyday',
              textAlign: TextAlign.center,
              style: Get.textTheme.subtitle1,
            ),
            const SizedBox(
              height: 49,
            ),
            // Lottie.asset('assets/lottie/quran.json'),
            // Container(child: ,)
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(),
                Image.asset(
                  'assets/image/intro.png',
                  height: 450,
                  width: 315,
                ),
                Positioned(
                  bottom: 24,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed(Routes.HOME),
                    child: const Text('Get Started'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fixedSize: Size(185, 60),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
