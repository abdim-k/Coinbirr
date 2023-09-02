import 'dart:io';

import 'package:applovin_max/applovin_max.dart';
import 'package:cash_rocket/Screen/Constant%20Data/constant.dart';
import 'package:cash_rocket/Videos/Admob/admob.dart';
import 'package:cash_rocket/Videos/AppLovin/applovin.dart';
import 'package:cash_rocket/Videos/StartApp/startapp.dart';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

import 'package:cash_rocket/generated/l10n.dart' as lang;


import '../../../Model/purchase_model.dart';
import '../../../Model/user_profile_model.dart';
import '../../../Provider/profile_provider.dart';
import '../../../Repositories/rewards_repo.dart';
import '../../../Videos/Audience Network/audience_network.dart';
import '../../../Videos/UnityAds/unity_ads.dart';
import '../../../Videos/Vungle/vungle.dart';
import '../no_internet_screen.dart';


class Ironsource with IronSourceRewardedVideoListener {
  @override
  void onRewardedVideoAdClicked(IronSourceRVPlacement placement) {
    print('onRewardedVideoAdClicked Placement: $placement');
  }

  @override
  void onRewardedVideoAdClosed() {
    print('onRewardedVideoAdClosed');
  }

  @override
  void onRewardedVideoAdEnded() {
    print('onRewardedVideoAdEnded');
  }

  @override
  void onRewardedVideoAdOpened() {
    print('onRewardedVideoAdOpened');
  }

  @override
  void onRewardedVideoAdRewarded(IronSourceRVPlacement placement) {
    print('onRewardedVideoAdRewarded Placement: $placement');
    // Implement your logic to reward the user here
  }

  @override
  void onRewardedVideoAdShowFailed(IronSourceError error) {
    print('onRewardedVideoAdShowFailed Error: $error');
  }

  @override
  void onRewardedVideoAdStarted() {
    print('onRewardedVideoAdStarted');
  }

  @override
  void onRewardedVideoAvailabilityChanged(bool isAvailable) {
    print('onRewardedVideoAvailabilityChanged: $isAvailable');
    // Update the UI based on the availability of rewarded videos
  }
}



class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

enum AdLoadState { notLoaded, loading, loaded }

class _VideosState extends State<Videos> {
  List<String> imageList = [
    'images/bg1.png',
    'images/bg3.png',
    'images/bg2.png',
  //  'images/bg4.png',
  //  'images/bg2.png',
  ];

  List<String> logoList = [
    'images/app.png',
    'images/am.png',
    'images/adgem.png',
  //  'images/adcolony.png',
 //   'images/sa.png',
  ];

  List<String> titleList = [
     '',
    '',
    '',
 //   '',
 //   '',
  ];
  List<String> subtitleList = [
    'Watch views and get Points',
    'Watch views and get Points',
    'Watch views and get Points',
    'Watch views and get Points',
    'Watch views and get Points',
  ];

  bool isBalanceShow = false;

  // FacebookRewardVideoAd facebookRewardVideoAd = FacebookRewardVideoAd();

  // Check that interstitial
  var isCanShow = Appodeal.canShow(AppodealAdType.RewardedVideo);

// Check that interstitial is loaded
  var isLoaded = Appodeal.isLoaded(AppodealAdType.RewardedVideo);

  // Admob admob = Admob();
//  FacebookRewardVideoAd facebookRewardVideoAd = FacebookRewardVideoAd();
  //

  AppLovin appLovin = AppLovin();

  void initialization() async {
    await AppLovinMAX.initialize(sdkKey);
    IronSource.validateIntegration();
    IronSource.setAdaptersDebug(true);
    Future<void> initIronSource() async {
      final appKey = '1b67e4185'; // Use the provided App Key from your dashboard

      try {
        IronSource.setFlutterVersion('2.8.1'); // Must be called before init
        IronSource.validateIntegration();
        IronSource.setRVListener(Ironsource()); // Set the implemented listener
        await IronSource.setAdaptersDebug(true);
        await IronSource.shouldTrackNetworkState(true);

        // Replace 'unique-application-user-id' with an actual user identifier
        // This could be the user's account ID, a UUID, or any other identifier
        await IronSource.setUserId('298631');

        // Initialize ironSource with the app key and ad units
        await IronSource.init(
          appKey: appKey,
          adUnits: [IronSourceAdUnit.RewardedVideo],
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }




    /* FacebookAudienceNetwork.init(
      testingId: "a77955ee-3304-4635-be65-81029b0f5201",
      iOSAdvertiserTrackingEnabled: true,
    );

   */

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
    Appodeal.setLogLevel(
        Appodeal.LogLevelVerbose); //default - Appodeal.LogLevelNone

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
              var response =
                  await RewardRepo().addPoint('10', 'Appodeal Video Ads');
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

  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result && mounted) {
      NoInternetScreen(screenName: widget).launch(context);
    }
  }


  @override
  void initState() {
    checkInternet();

    initialization();


    // facebookRewardVideoAd.loadRewardedVideoAd();
    //  admob.createRewardedAd();

    appLovin.loadAds();
    super.initState();
  }

  Future<void> attemptToShowAd() async {
    bool isVideoAvailable = await IronSource.isRewardedVideoAvailable();

    if (!isVideoAvailable) {
      Future.delayed(Duration(seconds: 1), () async {
        await attemptToShowAd();  // Recursive call
      });
    } else {
      IronSource.showRewardedVideo();
      print('IronSource Video Displayed');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, watch) {
      AsyncValue<UserProfileModel> profile = ref.watch(personalProfileProvider);
      return profile.when(data: (info) {
        return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              toolbarHeight: 90,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
              ),
              backgroundColor: kMainColor,
              elevation: 0.0,
              title: Text(
                lang.S.of(context).videos,
                style: kTextStyle.copyWith(color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
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
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
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
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "እባክዎን የተለያዩ ቪዲዮዎችን ማየትዎን ያረጋግጡ። በዚህ መንገድ ማስታወቂያ ሁል ጊዜ የሚገኝ ይሆናል።",
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 10.0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        titleList.length,
                        (i) {
                          return GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              int buttonClickCount =
                                  prefs.getInt('buttonClickCount') ?? 0;
                              String? lastButtonClickTimeStr =
                                  prefs.getString('lastButtonClickTime');
                              DateTime? lastButtonClickTime;

                              // Check if the saved button click time is not null and in a valid format
                              if (lastButtonClickTimeStr != null) {
                                try {
                                  lastButtonClickTime =
                                      DateTime.parse(lastButtonClickTimeStr);
                                } catch (e) {
                                  print('Error parsing button click time: $e');
                                }
                              }

                              print(
                                  'Initial buttonClickCount: $buttonClickCount');
                              print(
                                  'Initial lastButtonClickTime: $lastButtonClickTime');

                              // Check if the user has already clicked the button 50 times within 6 hours
                              if (buttonClickCount >= 25 &&
                                  lastButtonClickTime != null &&
                                  DateTime.now()
                                          .difference(lastButtonClickTime)
                                          .inHours <
                                      22) {
                                // Show a dialog...
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Click Limit Reached'),
                                      content: Text(
                                        'You have reached the maximum number of clicks allowed within 22 hours. \n እባክዎ ነገ ይመለሱ',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );

                                print('Click limit reached');
                                return;
                              }

                              // Check if the user waited for 6 hours since the last click
                              if (lastButtonClickTime != null &&
                                  DateTime.now()
                                          .difference(lastButtonClickTime)
                                          .inHours >=
                                      22) {
                                buttonClickCount =
                                    0; // Reset the click count to 0
                                print('Click count reset to 0');
                              }

                              // Save the current button click time
                              prefs.setString('lastButtonClickTime',
                                  DateTime.now().toString());

                              // Increment the button click count
                              buttonClickCount++;

                              // Commit the updated button click count to shared preferences
                              prefs.setInt(
                                  'buttonClickCount', buttonClickCount);

                              switch (i) {
                                case 0:

                                  Appodeal.show(AppodealAdType.RewardedVideo);
                                  print('Showing startApp ads');
                                  break;
                                case 1:
                                  appLovin.showAds(ref: ref);
                                  print('Showing Appodeal Rewarded Video');
                                  break;
                                case 2:
                                  attemptToShowAd();
                                  print('Showing appLovin ads');
                                  break;
                                case 3:
                                  print('Showing Vungle ad');
                                  break;
                                case 4:


                                  // Handle case 4
                                  break;
                                default:
                                  Appodeal.show(AppodealAdType.RewardedVideo);
                              }
                            },
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Container(
                                  height: 150,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: AssetImage(imageList[i]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 20.0,
                                        backgroundImage:
                                            AssetImage(logoList[i]),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        titleList[i],
                                        style: kTextStyle.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        subtitleList[i],
                                        style: kTextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ));
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
