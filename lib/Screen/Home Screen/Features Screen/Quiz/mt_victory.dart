// ignore_for_file: unused_result

import 'package:cash_rocket/Screen/Home%20Screen/home.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '../../../../Provider/profile_provider.dart';
import '../../../../Videos/UnityAds/unity_ads.dart';
import '../../../Constant Data/constant.dart';

class Victory extends StatefulWidget {
  const Victory({Key? key, required this.score, required this.questions, required this.point}) : super(key: key);
  final String score, questions,point;
  @override
  State<Victory> createState() => _VictoryState();
}

class _VictoryState extends State<Victory> {
  AdManager adManager =
  AdManager();
  final InAppReview _inAppReview = InAppReview.instance;
  String select = 'com.pioneerdev.coinbirr';

  List<String> option = [
    'Share Score',
    'Rate Us',
    'Home',
  ];

  void review() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
    } else {
      toast('Review Not Available');
    }
  }

  @override
  void initState() {

    super.initState();


    UnityAds.init(
      gameId: '5321840',
      onComplete: () => print('Initialization Complete'),
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)  {
      // Create an instance of the AdManager class


      adManager.loadUnityAd2();// Access the method through the instance
    });
    // remove this code on final product
    /* FacebookAudienceNetwork.init(
        testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
        iOSAdvertiserTrackingEnabled: true //default false
    );

    */
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ref,__) {
        ref.refresh(personalProfileProvider);
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: const AssetImage('images/bg.png'),
                width: context.width(),
                height: context.height(),
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: context.width() / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      lang.S.of(context).congratulations,
                      style: kTextStyle.copyWith(color: kGreyTextColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      lang.S.of(context).victory,
                      style: kTextStyle.copyWith(
                          color: kTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 170,
                      width: 170,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/victory.png'),
                        ),
                      ),
                    ),
                    Text(
                      lang.S.of(context).winner,
                      style: kTextStyle.copyWith(
                          color: kTitleColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(6.0),
                                  color: const Color(0xFF8555EA),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Icon(FeatherIcons.check,
                                        size: 16.0, color: Colors.white),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      '${widget.questions}/${widget.questions}',
                                      style: kTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(6.0),
                                  color: const Color(0xFF2F81E8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Icon(FeatherIcons.x,
                                        color: Colors.white, size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      '0/${widget.questions}',
                                      style: kTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: CircularPercentIndicator(
                            radius: 40.0,
                            progressColor: kMainColor,
                            circularStrokeCap: CircularStrokeCap.round,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 1,
                            center: const Text(
                              "100%",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(6.0),
                                  color: const Color(0xFFFF8244),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Icon(FeatherIcons.award,
                                        color: Colors.white, size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      widget.point,
                                      style: kTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(6.0),
                                  color: const Color(0xFF4EB000),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Icon(FeatherIcons.database,
                                        color: Colors.white, size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      widget.questions,
                                      style: kTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Card(
                      elevation: 1.0,
                      color: kMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          Share.share('I have earned \$10 in a day. Use my refer code to earn \$10 on signup. . Download the app now and start your journey of making money online: https://play.google.com/store/apps/details?id=com.pioneerdev.coinbirr&pli=1',
                              subject: 'Look what I made answering simple quiz about Ethiopia');
                        },
                        title: Text(
                          lang.S.of(context).shareSqure,
                          textAlign: TextAlign.center,
                          style: kTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ListTile(
                        onTap: review,
                        title: Text(
                          lang.S.of(context).rateUs,
                          textAlign: TextAlign.center,
                          style: kTextStyle.copyWith(
                              color: kTitleColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            AdManager.showIntAd2();
                            const Home().launch(context);
                          });
                        },
                        title: Text(
                          lang.S.of(context).home,
                          textAlign: TextAlign.center,
                          style: kTextStyle.copyWith(
                              color: kTitleColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
