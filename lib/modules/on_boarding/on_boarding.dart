import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/cache_wrapper.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController = PageController();

  final List<BordingItemModel> listofBordingScreens = [
    BordingItemModel(
        image: 'assets/images/onboard1.png',
        text: 'On Board 1 Title',
        body: 'On Board 1 Title'),
    BordingItemModel(
        image: 'assets/images/onboard2.png',
        text: 'On Board 2 Title',
        body: 'On Board 2 Title'),
    BordingItemModel(
        image: 'assets/images/onboard3.png',
        text: 'On Board 3 Title',
        body: 'On Board 3 Title'),
  ];

  bool isLast = false;
  void submit() {
    CacheWrapper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          // (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemBuilder: (context, index) =>
                    buildingOnBordItem(listofBordingScreens[index]),
                itemCount: listofBordingScreens.length,
                onPageChanged: (index) {
                  // print(index);
                  if (index == listofBordingScreens.length - 1) {
                    setState(() {
                      isLast = true;
                      print('last page');
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: Colors.deepPurple,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 4,
                  ), // your preferred// effect
                  onDotClicked: (index) {
                    // if (index == listofBordingScreens.length) {
                    //   print(index);
                    //   _pageController.jumpToPage(index);
                    // } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                    // }
                  },
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  icon: Icon(Icons.skip_next),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildingOnBordItem(BordingItemModel modelOfData) => Column(
      children: [
        Image(
          image: AssetImage(modelOfData.image),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          modelOfData.text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(modelOfData.body),
      ],
    );

class BordingItemModel {
  final String image;
  final String text;
  final String body;

  BordingItemModel(
      {required this.image, required this.text, required this.body});
}
