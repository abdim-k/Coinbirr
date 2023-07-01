import 'package:applovin_max/applovin_max.dart';
import 'package:cash_rocket/Screen/Constant%20Data/constant.dart';
import 'package:cash_rocket/Videos/Admob/admob.dart';
import 'package:cash_rocket/Videos/AppLovin/applovin.dart';
import 'package:cash_rocket/Videos/StartApp/startapp.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:startapp_sdk/startapp.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '../../../Model/user_profile_model.dart';
import '../../../Provider/profile_provider.dart';
import '../../../Videos/Audience Network/audience_network.dart';
import '../../../Videos/UnityAds/unity_ads.dart';
import '../no_internet_screen.dart';

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

enum AdLoadState { notLoaded, loading, loaded }

class _VideosState extends State<Videos> {
  List<String> imageList = [
    'images/bg1.png',
    'images/bg2.png',
    // 'images/bg3.png',
    // 'images/bg4.png',
    'images/bg2.png',
  ];

  List<String> logoList = [
    'images/app.png',
    'images/sa.png',
    //'images/am.png',
    // 'images/an.png',
    'images/an.png',


  ];

  List<String> titleList = [
    'AppLovin',
    'StartApp',
   // 'AdMob',
    //'Audience Network',
    'Unity'
  ];
  List<String> subtitleList = [
    'Watch views and get Points',
    'Watch views and get Points',
   // 'Watch views and get Points',
  //  'Watch views and get Points',
    'Watch views and get Points',
  ];

  bool isBalanceShow = false;
  var startAppSdk = StartAppSdk();
  // Admob admob = Admob();
//  FacebookRewardVideoAd facebookRewardVideoAd = FacebookRewardVideoAd();
  StartApp startApp = StartApp();
  AppLovin appLovin = AppLovin();
  AdManager adManager =
  AdManager();

 /* void initialization() async{
    await AppLovinMAX.initialize(sdkKey);
    FacebookAudienceNetwork.init(
      testingId: "a77955ee-3304-4635-be65-81029b0f5201",
      iOSAdvertiserTrackingEnabled: true,
    );
  }

  */

  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result && mounted) {
      NoInternetScreen(screenName: widget).launch(context);
    }
  }

  @override
  void initState() {
    checkInternet();
   // initialization();
 //   facebookRewardVideoAd.loadRewardedVideoAd();
  //  admob.createRewardedAd();

    appLovin.loadAds();
    super.initState();
    UnityAds.init(
      gameId: '5321840',
      onComplete: () => print('Initialization Complete'),
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    // Create an instance of the AdManager class
      await adManager.loadUnityAd3(); // Access the method through the instance
    });
  }
bool isFirst = true;
  @override
  Widget build(BuildContext context) {

    return Consumer(builder: (_,ref,watch){
      isFirst? startApp.loadRewardedVideoAd(ref: ref):null;
      isFirst = true;
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
                            border: Border.all(color: Colors.white, width: 2.0),
                          ),
                          child: const Icon(
                            FeatherIcons.dollarSign,
                            size: 15.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Text(isBalanceShow ? '${info.data?.user?.wallet?.balance ?? ''}' : lang.S.of(context).balance),
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
          body: SingleChildScrollView(
            child: Column(
              children: [
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
                        return Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Container(
                              height: 150,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: AssetImage(
                                      imageList[i],
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 20.0,
                                    backgroundImage: AssetImage(
                                      logoList[i],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    titleList[i],
                                    style: kTextStyle.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    subtitleList[i],
                                    style: kTextStyle.copyWith(
                                        color: Colors.white, fontSize: 12.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ).onTap(() async {
                          switch (i) {
                            case 0:
                              appLovin.showAds(ref: ref);
                              break;
                            case 1:
                              startApp.showAds();
                              break;
                         /*   case 2:
                              print('Ad not available');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Ad not available'),
                                ),
                              );
                              break;
                            case 3:
                              facebookRewardVideoAd.showRewardedAd();
                              break;

                          */
                            case 2:
                              await AdManager.showIntAd3(ref: ref);
                              break;
                            default:
                              startApp.showAds();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
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