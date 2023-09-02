// ignore_for_file: use_build_context_synchronously, unused_result



import 'dart:io';

import 'package:applovin_max/applovin_max.dart';
import 'package:cash_rocket/Model/user_profile_model.dart';
import 'package:cash_rocket/Provider/profile_provider.dart';
import 'package:cash_rocket/Repositories/authentication_repo.dart';
import 'package:cash_rocket/Screen/Constant%20Data/constant.dart';
import 'package:cash_rocket/Screen/Home%20Screen/Features%20Screen/mt_quiz.dart';
import 'package:cash_rocket/Screen/Home%20Screen/Features%20Screen/mt_videos.dart';
import 'package:cash_rocket/Screen/Home%20Screen/home.dart';
import 'package:cash_rocket/Screen/Home%20Screen/no_internet_screen.dart';
import 'package:cash_rocket/Screen/Profile/mt_profile.dart';
import 'package:cash_rocket/Videos/Admob/admob.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';


import 'package:share_plus/share_plus.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import '../../Model/purchase_model.dart';
import '../../Provider/database_provider.dart';
import '../../Videos/AppLovin/applovin.dart';
import '../../Videos/UnityAds/unity_ads.dart';
import '../Authentication/log_in.dart';
import '../Constant Data/config.dart';
import '../Offer Toro/offertoro_offerwall.dart';
import 'Features Screen/mt_refer.dart';
import 'Features Screen/mt_wheel.dart';
import 'Features Screen/redeem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _banner_ad_unit_id = Platform.isAndroid ? "a1166258f03aacc2" : "IOS_BANNER_AD_UNIT_ID";

  AppLovin appLovin = AppLovin();


  var isCanShow =  Appodeal.canShow(AppodealAdType.RewardedVideo);
// Check that interstitial is loaded
  var isLoaded =  Appodeal.isLoaded(AppodealAdType.RewardedVideo);
  // Admob admob = Admob();
//  FacebookRewardVideoAd facebookRewardVideoAd = FacebookRewardVideoAd();
  //
  // bool isInterstitialLoaded=false;
  YoutubePlayerController videoController = YoutubePlayerController(
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
    initialVideoId: '-_9iisRQ5qs',
  );

  void initialization() async {
    await AppLovinMAX.initialize(sdkKey);
    AppLovinMAX.createBanner(_banner_ad_unit_id, AdViewPosition.topCenter);

    Appodeal.initialize(
        appKey: "8abe453f94ee0c37eebaac9843e988973d535af009e5ebdd",
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
      onRewardedVideoFailedToLoad: () {
        // Appodeal rewarded video failed to load
        // Implement logic to show alternative ad networks
      //  showAlternativeAdNetworks();
      },
      onRewardedVideoShown: () => {},
      onRewardedVideoShowFailed: () => {},
      onRewardedVideoFinished: (amount, reward) async {},
      onRewardedVideoClosed: (isFinished) => {},
      onRewardedVideoExpired: () => {},
      onRewardedVideoClicked: () => {},
    );

  }

/*
  void showAlternativeAdNetworks() {
    // Logic to show alternative ad networks, e.g., AppLovin, other networks
    // For AppLovin:
    appLovin.showInterstitialAd();
    // You can add more alternative ad networks here
  }

 */




  @override
  void initState() {
    checkInternet();
    checkAndUpdate();
    appLovin.loadAds();
    initialization();


    //   facebookRewardVideoAd.loadRewardedVideoAd();
    //  admob.createRewardedAd();


    super.initState();




    // remove this code on final product
    /* FacebookAudienceNetwork.init(
        testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
        iOSAdvertiserTrackingEnabled: true //default false
    );

    */
  }

  /* @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadInterstitial();
  }

  void loadInterstitial() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#793824048967170_813764000306508", // add # your id after test id
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED)
          FacebookInterstitialAd.showInterstitialAd(delay: 5000);
      },
    );
  }

   */


  void checkAndUpdate() {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              // App Update successful
              // You can show a message or perform any post-update logic here
            } else {
              // Handle update failure or user cancellation
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          // Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              // App Update successful
              InAppUpdate.completeFlexibleUpdate();
              // You can show a message or perform any post-update logic here
            } else {
              // Handle update failure or user cancellation
            }
          });
        }
      }
    });
  }


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
                                style: kTextStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                '$amount Points received',
                                style: kTextStyle.copyWith(color: Colors.white),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      colors: [
                                        Color(0xFFFFBF53),
                                        Color(0xFFFF8244),
                                      ]),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Text(
                                    lang.S.of(context).ok,
                                    style: kTextStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ).onTap(
                                    () => {
                                  finish(context),
                                  const Home().launch(context),
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    ).then((value) {
      appLovin.showInterstitialAd();
     // Appodeal.show(AppodealAdType.RewardedVideo);
      // This code block will execute after the dialog is closed
      //   FacebookInterstitialAd.showInterstitialAd();
    });
  }

  void showRewardsPopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: const DecorationImage(
                          image: AssetImage('images/banner3.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10.0),
                          Text(
                            lang.S.of(context).dailyReward,
                            style: kTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Already rewarded\ncome back later',
                            style: kTextStyle.copyWith(
                                color: Colors.white, fontSize: 18.0),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color(0xFFFFBF53),
                                    Color(0xFFFF8244),
                                  ]),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
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
        );
      },
    ).then((value) {
      Appodeal.show(AppodealAdType.RewardedVideo);
      // This code block will execute after the dialog is closed
      //   FacebookInterstitialAd.showInterstitialAd();
    });
  }


  List<String> bannerList = [
    'images/banner1.png',
    'images/banner2.png',
  ];
  List<String> featureList = [
    'images/offer.png',
    'images/videos.png',
    'images/wheel.png',
    'images/refer.png',
  ];
  List<String> featureList2 = [
    'images/redeem.png',
    'images/quiz.png',
    'images/tutorial.png',
    'images/share.png',
  ];
  bool isBalanceShow = false;

  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result && mounted) {
      NoInternetScreen(screenName: widget).launch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, watch) {
      AsyncValue<UserProfileModel> profile = ref.watch(personalProfileProvider);
      return profile.when(data: (info) {
        if (info.data?.user?.status == 0) {
          DataBase().deleteToken();
          EasyLoading.showError('You Are Disable!');
          const LogIn().launch(context, isNewTask: true);
        }

        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Scaffold(
            appBar: AppBar(

              titleSpacing: 0.0,
              automaticallyImplyLeading: false,
              backgroundColor: kMainColor,
              elevation: 0.0,
              title: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.white)),
                  child: CircleAvatar(
                    radius: 18.0,
                    backgroundImage: NetworkImage(info.data?.user?.image ==
                        Config.siteUrl
                        ? 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png'
                        : info.data?.user?.image ??
                        'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png'),
                  ),
                ).onTap(
                      () => const Profile().launch(context),
                ),
                title: Text(
                  info.data?.user?.name ?? '',
                  style: kTextStyle.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
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
                              size: 15.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Text(isBalanceShow
                            ? '${info.data?.user?.wallet?.balance ?? ''}'
                            : lang.S.of(context).balance),
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
            body: RefreshIndicator(
              onRefresh: () async {
                ref.refresh(personalProfileProvider);
                ref.refresh(withdrawHistoryProvider);
                ref.refresh(userHistoryProvider);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: context.width(),
                      decoration: const BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.only(left: 4.0),
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 25,
                                  backgroundImage: AssetImage('images/meter.png'),
                                ),
                                title: Center(
                                  child: Text(
                                    lang.S.of(context).collectDailyRewardNow,
                                    style: kTextStyle.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                trailing: Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Text(
                                      '20+',
                                      style: kTextStyle.copyWith(
                                          color: kMainColor,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ).onTap(
                                  () async {
                                try {
                                  EasyLoading.show(
                                      status: 'Getting Today\'s Reward');
                                  bool isValid =
                                  await PurchaseModel().isActiveBuyer();
                                  if (isValid) {
                                    var status = await AuthRepo().dailyRewards();
                                    if (status) {
                                      showRewardPopUp('100');
                                      EasyLoading.showSuccess('Reward Added');
                                    //  admob.showInterstitialAd();
                                      ref.refresh(personalProfileProvider);
                                    } else {
                                      EasyLoading.showError(
                                          'Already Rewarded. Try Again Later');
                                      showRewardsPopUp();
                                    }
                                  } else {
                                    showLicense(context: context);
                                  }
                                } catch (e) {
                                  showRewardsPopUp();
                                  EasyLoading.showError(
                                      e.toString().replaceRange(0, 10, ''));
                                }
                              },
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    HorizontalList(
                      itemCount: bannerList.length,
                      itemBuilder: (_, i) {
                        return Container(
                          height: 150,
                          width: 305,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                bannerList[i],
                              ),
                            ),
                          ),
                        ).onTap(() {
                          if (i == 0) {
                            const Redeem().launch(context);
                          } else {
                            Share.share(
                                'I have earned \$10 in a day. Use my refer code to earn \$10 on signup. My Refer Code is ${info.data?.user?.referCode ?? ''}. Download the app now and start your journey of making money online: https://play.google.com/store/apps/details?id=com.pioneerdev.coinbirr&pli=1');
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.S.of(context).allFeatures,
                            style: kTextStyle.copyWith(
                                color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Image(
                                    image: AssetImage('images/quiz.png'),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Center(
                                      child: Text(
                                        lang.S.of(context).quizz,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ).onTap(
                                    () => const MtQuiz().launch(context),
                              ),
                             /* Column(
                                children: [
                                  const Image(
                                    image: AssetImage('images/offer.png'),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Center(
                                      child: Text(
                                        lang.S.of(context).offers,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ).onTap(
                                    () => ComingSoonScreen().launch(context),
                              ),

                              */
                              Column(
                                children: [
                                  const Image(
                                    image: AssetImage('images/videos.png'),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Center(
                                      child: Text(
                                        lang.S.of(context).videos,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ).onTap(
                                    () => const Videos().launch(context),
                              ),
                              Column(
                                children: [
                                  const Image(
                                    image: AssetImage('images/wheel.png'),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Center(
                                      child: Text(
                                        lang.S.of(context).wheel,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ).onTap(
                                    () => const Wheel().launch(context),
                              ),
                              /*Column(
                                children: [
                                  const Image(
                                    image: AssetImage('images/refer.png'),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Center(
                                      child: Text(
                                        lang.S.of(context).refer,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ).onTap(
                                    () => const Refer().launch(context),
                              ),

                               */
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,

                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(

                                child: Column(
                                  children: [
                                    const Image(
                                      image: AssetImage('images/reedem.png'),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Center(
                                        child: Text(
                                          lang.S.of(context).redeemm,
                                          style: kTextStyle.copyWith(
                                              color: kTitleColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ).onTap(
                                      () => const Redeem().launch(context),
                                ),
                              ),

                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: YoutubePlayer(
                                            controller: videoController,
                                            showVideoProgressIndicator: true,
                                            onReady: () {},
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      const Image(
                                        image: AssetImage('images/tutorial.png'),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Center(
                                          child: Text(
                                            lang.S.of(context).tutorial,
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Image(
                                      image: AssetImage('images/share.png'),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Center(
                                      child: Text(
                                        lang.S.of(context).share,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: kTextStyle.copyWith(
                                            color: kTitleColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ).onTap(() => Share.share(
                                    'I have earned \$10 in a day. Use my refer code to earn \$10 on signup. My Refer Code is ${info.data?.user?.referCode ?? ''}. Download the app now and start your journey of making money online: https://play.google.com/store/apps/details?id=com.pioneerdev.coinbirr&pli=1')),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FutureBuilder(
                                  future: Future.delayed(Duration.zero, () {
                                    AppLovinMAX.showBanner(_banner_ad_unit_id);
                                  }),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Container(); // or a loading spinner
                                    } else {
                                      if (snapshot.hasError)
                                        return Text('Error: ${snapshot.error}');
                                      else
                                        return Container(); // Your ad will be shown here
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

          ),
        );
      }, error: (e, stack) {
        return Center(
          child: Text(e.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
    });
  }
}