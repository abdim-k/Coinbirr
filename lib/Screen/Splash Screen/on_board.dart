import 'package:cash_rocket/Screen/Authentication/log_in.dart';
import 'package:cash_rocket/Screen/Constant%20Data/button_global.dart';
import 'package:cash_rocket/Screen/Constant%20Data/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;
  List<Map<String, dynamic>> sliderList = [
    {
      "title": 'Welcome to Coinbirr',
      "description": 'Watch, Play, Get Paid! Earn rewards for watching videos and winning quizzes. Turn your entertainment into earnings with this exciting app.',
      "icon": 'images/onboard1.png',
    },
    {
      "title": 'Redeem Your Points',
      "description": 'Easily redeem your hard-earned points with CoinBirr. Use TeleBirr, Bank transfers, or Mobile airtime to cash out and enjoy your rewards. Cash out anytime, anywhere!',
      "icon": 'images/onboard2.png',
    },
    {
      "title": 'Secure Your Money',
      "description": 'Enjoy secure transactions and peace of mind while using CoinBirr to manage your earnings.',
      "icon": 'images/onboard3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image(
              image: const AssetImage('images/bg.png'),
              width: context.width(),
              height: context.height(),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: PageView.builder(
                itemCount: sliderList.length,
                controller: pageController,
                onPageChanged: (int index) => setState(() => currentIndexPage = index),
                itemBuilder: (_, i) {
                  return Stack(
                    children: [
                      Container(
                        height: context.height() / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              sliderList[i]['icon'],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: context.height() / 2.5,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.white),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20.0),
                                Text(
                                  sliderList[i]['title'].toString(),
                                  style: kTextStyle.copyWith(color: kTitleColor, fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  sliderList[i]['description'].toString(),
                                  style: kTextStyle.copyWith(color: kGreyTextColor),
                                  maxLines: 5,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 30.0),
                                SmoothPageIndicator(
                                  controller: pageController,
                                  count: 3,
                                  effect: ExpandingDotsEffect(
                                    dotHeight: 5.0,
                                    dotWidth: 5.0,
                                    activeDotColor: kMainColor,
                                    dotColor: kMainColor.withOpacity(0.2),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                ButtonGlobal(
                                    buttontext: lang.S.of(context).next,
                                    buttonDecoration: kButtonDecoration,
                                    onPressed: () {
                                      setState(() {
                                        currentIndexPage < 2;
                                        currentIndexPage < 2
                                            ? pageController.nextPage(duration: const Duration(microseconds: 3000), curve: Curves.bounceInOut)
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const LogIn(),
                                                ),
                                              );
                                      });
                                    }),
                                const SizedBox(height: 20.0),
                                Text(
                                  lang.S.of(context).skipForNow,
                                  style: kTextStyle.copyWith(color: kGreyTextColor),
                                ).onTap(
                                  () async => const LogIn().launch(context),
                                ),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
