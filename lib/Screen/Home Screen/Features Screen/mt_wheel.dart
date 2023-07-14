// ignore_for_file: unused_result

import 'dart:async';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import 'package:cash_rocket/Model/user_profile_model.dart';
import 'package:cash_rocket/Provider/database_provider.dart';
import 'package:cash_rocket/Provider/profile_provider.dart';
import 'package:cash_rocket/Screen/Constant%20Data/button_global.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:startapp_sdk/startapp.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../../../Model/purchase_model.dart';
import '../../../Repositories/rewards_repo.dart';
import '../../../Videos/Admob/admob.dart';
import '../../../Videos/StartApp/startapp.dart';
import '../../../Videos/UnityAds/unity_ads.dart';
import '../../../test/src/core/core.dart';
import '../../../test/src/indicators/indicators.dart';
import '../../../test/src/wheel/wheel.dart';
import '../../Constant Data/constant.dart';
import '../home.dart';
import '../no_internet_screen.dart';

class Wheel extends StatefulWidget {
  const Wheel({Key? key}) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  StreamController<int> selected = StreamController<int>();
  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result && mounted) {
      NoInternetScreen(screenName: widget).launch(context);
    }
  }

  var isCanShow =  Appodeal.canShow(AppodealAdType.RewardedVideo);
// Check that interstitial is loaded
  var isLoaded =  Appodeal.isLoaded(AppodealAdType.RewardedVideo);

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }
  AdManager adManager =
  AdManager();

  @override
  void initState() {
    checkInternet();
    admob.createRewardedAd();
    admob.createInterstitialAd();
    super.initState();
    UnityAds.init(
      gameId: '5321840',
      onComplete: () => print('Initialization Complete'),
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)  {
      // Create an instance of the AdManager class

      adManager.loadUnityAd();
      adManager.loadUnityAd2();// Access the method through the instance
    });

    Appodeal.initialize(
        appKey: "f68b186e0f441ab28d3b23c9e39d28f3a4a4df6f0bda3fce",
        adTypes: [

          AppodealAdType.RewardedVideo,

        ],
        onInitializationFinished: (errors) => {});
    // Set ad auto caching enabled or disabled
// By default autocache is enabled for all ad types
    Appodeal.setAutoCache(AppodealAdType.Interstitial, false); //default - true

// Set testing mode
    Appodeal.setTesting(false); //default - false

// Set Appodeal SDK logging level
    Appodeal.setLogLevel(Appodeal.LogLevelVerbose); //default - Appodeal.LogLevelNone

// Enable or disable child direct threatment
    Appodeal.setChildDirectedTreatment(false); //default - false

// Disable network for specific ad type
    Appodeal.disableNetwork("admob");
    Appodeal.disableNetwork("admob", AppodealAdType.Interstitial);

    Appodeal.setRewardedVideoCallbacks(
        onRewardedVideoLoaded: (isPrecache) => {},
        onRewardedVideoFailedToLoad: () => {},
        onRewardedVideoShown: () => {},
        onRewardedVideoShowFailed: () => {},
        onRewardedVideoFinished: (amount, reward) async {
          try {
            EasyLoading.show(status: 'Getting rewards');
            bool isValid = await PurchaseModel().isActiveBuyer();
            if (isValid) {
              var response = await RewardRepo().addPoint('10', 'Appodeal Video Ads');
              if (response) {
                EasyLoading.showSuccess('You Have Earned 10 Coins');

              } else {
                EasyLoading.showError('Error Happened. Try Again');
              }
            } else {
              EasyLoading.showError('Please check your purchase code');
            }
          } catch (e) {
            EasyLoading.showError(e.toString());
          }
        },

        onRewardedVideoClosed: (isFinished) => {},
        onRewardedVideoExpired: () => {},
        onRewardedVideoClicked: () => {});
  }

  bool isBalanceShow = false;
  Admob admob = Admob();
  var startAppSdk = StartAppSdk();
  StartApp startApp = StartApp();
  bool isFirst = true;

  void showRewardPopUp(String amount) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                              image: AssetImage('images/rewardbanner.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20.0),
                              Text(
                                lang.S.of(context).congratulations,
                                style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                '$amount ${lang.S.of(context).pointRecived}',
                                style: kTextStyle.copyWith(color: Colors.white),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(begin: Alignment.topCenter, colors: [
                                    Color(0xFFFFBF53),
                                    Color(0xFFFF8244),
                                  ]),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Text(
                                    lang.S.of(context).ok,
                                    style: kTextStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ).onTap(() => {
                                    finish(context),
                                    const Home().launch(context),
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool isChecked = true;

  @override
  Widget build(BuildContext context) {


    final items = <String>[
      '10',
      '20',
      '30',
      '40',

    ];
    return SafeArea(

      child: Scaffold(
        body: Consumer(builder: (_, ref, watch) {
          isFirst? startApp.loadRewardedVideoAd(ref: ref):null;
          isFirst = true;
          AsyncValue<UserProfileModel> profile = ref.watch(personalProfileProvider);
          AsyncValue<UserProfileModel> userInfo = ref.watch(personalProfileProvider);
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Image(
                image: const AssetImage('images/bg.png'),
                width: context.width(),
                height: context.height(),
                fit: BoxFit.cover,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            FeatherIcons.arrowLeft,
                            color: Colors.white,
                          ).onTap(
                            () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            lang.S.of(context).wheel,
                            style: kTextStyle.copyWith(color: Colors.white, fontSize: 18.0),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 30.0, bottom: 15.0, top: 15.0),
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.white.withOpacity(0.3),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AnimatedOpacity(
                                    opacity: !isBalanceShow ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 1000),
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.0),
                                        color: kMainColor,
                                        border: Border.all(color: Colors.white, width: 2.0),
                                      ),
                                      child: const Icon(
                                        FeatherIcons.dollarSign,
                                        color: Colors.white,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  userInfo.when(data: (info) {
                                    return Text(
                                      isBalanceShow ? '\$${info.data?.user?.wallet?.balance ?? ''}' : lang.S.of(context).balance,
                                      style: kTextStyle.copyWith(color: Colors.white),
                                    );
                                  }, error: (e, stack) {
                                    return Text(
                                      e.toString(),
                                      style: kTextStyle.copyWith(color: Colors.white),
                                    );
                                  }, loading: () {
                                    return Container();
                                  }),
                                  const SizedBox(width: 5.0),
                                  AnimatedOpacity(
                                    opacity: isBalanceShow ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 1000),
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.0),
                                        color: kMainColor,
                                        border: Border.all(color: Colors.white, width: 2.0),
                                      ),
                                      child: const Icon(
                                        FeatherIcons.dollarSign,
                                        color: Colors.white,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).onTap(() {
                              setState(() {
                                isBalanceShow = !isBalanceShow;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: context.width() / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.S.of(context).spinTheWheel,
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            lang.S.of(context).pressTheSpinWheel,
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: context.height() / 2,
                                width: 340,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/wheelbanner.png'),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DataBase().saveString('spinTime', DateTime.now().toString());
                                  int se = Fortune.randomInt(0, items.length);
                                  selected.add(se);
                                  await Future.delayed(const Duration(seconds: 5));
                                  try {
                                    EasyLoading.show(status: 'Getting rewards');
                                    var response = await RewardRepo().addPoint(items[se], 'Spin Wheel Video Ads');
                                    if (response) {
                                      showRewardPopUp(items[se]);
                                      EasyLoading.showSuccess('You Have Earned ${items[se]} Coins');
                                      AdManager.showIntAd2();
                                      ref.refresh(personalProfileProvider);
                                    } else {
                                      EasyLoading.showError('Error Happened. Try Again');
                                    }
                                  } catch (e) {
                                    EasyLoading.showError(e.toString());
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: FortuneWheel(
                                        animateFirst: false,
                                        selected: selected.stream,
                                        indicators: const <FortuneIndicator>[
                                          FortuneIndicator(
                                            alignment: Alignment.topCenter,
                                            // <-- changing the position of the indicator
                                            child: TriangleIndicator(
                                              color: Colors.yellow, // <-- changing the color of the indicator
                                            ),
                                          ),
                                        ],
                                        items: [
                                          for (var it in items)
                                            FortuneItem(
                                              child: Text(it),
                                              style: const FortuneItemStyle(
                                                color: kMainColor,
                                                borderColor: Colors.yellow,
                                                borderWidth: 3,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 50.0),
                          ButtonGlobal(buttontext: lang.S.of(context).watchVideoAndEarn, buttonDecoration: kButtonDecoration, onPressed: (){
                            // admob.showRewardedAd(ref: ref);
                            Appodeal.show(AppodealAdType.RewardedVideo);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
