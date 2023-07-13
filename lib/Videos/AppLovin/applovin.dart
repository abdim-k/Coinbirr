// ignore_for_file: unused_result

import 'dart:io';
import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Provider/database_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Repositories/rewards_repo.dart';


class AppLovin {
  var _rewardedAdRetryAttempt = 0;
  var _interstitialRetryAttempt = 0;

  Future<void> loadAds() async {
    final String rewardedAdUnitId =  Platform.isAndroid ?await DataBase().retrieveString('applovinRewardedAdAndroid') ?? "b6a2ecde63205294" : await DataBase().retrieveString('applovinRewardedAdIos') ?? "b6a2ecde63205294";
    final String interstitialAdUnitId = Platform.isAndroid ? "ded2daf815676443" : "ded2daf815676443";
    toast("Initializing SDK...");
    AppLovinMAX.loadRewardedAd(rewardedAdUnitId);
    AppLovinMAX.loadInterstitial(interstitialAdUnitId);
  }
  void initializeRewardedAds({required WidgetRef ref}) {
    AppLovinMAX.setRewardedAdListener(RewardedAdListener(
      onAdLoadedCallback: (ad) {
        // Rewarded ad is ready to be shown. AppLovinMAX.isRewardedAdReady(_rewarded_ad_unit_id) will now return 'true'
        toast('Rewarded ad loaded from ${ad.networkName}');

        // Reset retry attempt
        _rewardedAdRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Rewarded ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _rewardedAdRetryAttempt = _rewardedAdRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _rewardedAdRetryAttempt)).toInt();
        toast('Rewarded ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          loadAds();
        });
      },
      onAdDisplayedCallback: (ad) {
        toast('Rewarded ad loaded from ${ad.networkName}');
      },
      onAdDisplayFailedCallback: (ad, error) {
        toast(error.message.toString());
      },
      onAdClickedCallback: (ad) {
        toast('Ad Clicked');
      },
      onAdHiddenCallback: (ad) {
        toast('Ad Hidden');
      },
      onAdReceivedRewardCallback: (ad, reward) async {
        try {
          print('Reward received: $reward'); // Debug output

          EasyLoading.show(status: 'Getting rewards');
          var response = await RewardRepo().addPoint('10', 'Applovin Video Ads');
          print('addPoint response: $response'); // Debug output

          if (response) {
            EasyLoading.showSuccess('You Have Earned 10 Coins');
            ref.refresh(personalProfileProvider);
          } else {
            EasyLoading.showError('Error Happened. Try Again');
          }
        } catch (e) {
          EasyLoading.showError(e.toString());
        }
      },
    ));
  }

  void showAds({required WidgetRef ref}) async {
    final String rewardedAdUnitId =  Platform.isAndroid ?await DataBase().retrieveString('applovinRewardedAdAndroid') ?? "b6a2ecde63205294" : await DataBase().retrieveString('applovinRewardedAdIos') ?? "b6a2ecde63205294";

    bool isReady = (await AppLovinMAX.isRewardedAdReady(rewardedAdUnitId))!;
    if (isReady) {
      initializeRewardedAds(ref: ref);
      AppLovinMAX.showRewardedAd(rewardedAdUnitId);
      loadAds();
    }else{
      loadAds();
    }
  }
  void initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialAdReady(_interstitial_ad_unit_id) will now return 'true'
        toast('Interstitial ad loaded from ${ad.networkName}');

        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();
        toast('Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          loadAds();
        });
      },
      onAdDisplayedCallback: (ad) {
        toast('ad displayed from ${ad.networkName}');
      },
      onAdHiddenCallback: (ad) {
        toast('');
      },
      onAdClickedCallback: (ad) {
        toast('');
      }, onAdDisplayFailedCallback: (MaxAd ad, MaxError error) { toast('Ad is not ready'); },
    ));
  }

  void showInterstitialAd() async {
    final String interstitialAdUnitId = Platform.isAndroid
        ? await DataBase().retrieveString('applovinInterstitialAdAndroid') ?? "ded2daf815676443"
        : await DataBase().retrieveString('applovinInterstitialAdIos') ?? "ded2daf815676443";

    bool isReady = (await AppLovinMAX.isInterstitialReady(interstitialAdUnitId))!;
    if (isReady) {
      initializeInterstitialAds();
      AppLovinMAX.showInterstitial(interstitialAdUnitId);
      loadAds();
    } else {
      loadAds();
    }
  }

  void initializeRewardedAds2() {
    AppLovinMAX.setRewardedAdListener(RewardedAdListener(
      onAdLoadedCallback: (ad) {
        // Rewarded ad is ready to be shown. AppLovinMAX.isRewardedAdReady(_rewarded_ad_unit_id) will now return 'true'
        toast('Rewarded ad loaded from ${ad.networkName}');

        // Reset retry attempt
        _rewardedAdRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Rewarded ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _rewardedAdRetryAttempt = _rewardedAdRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _rewardedAdRetryAttempt)).toInt();
        toast('Rewarded ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          loadAds();
        });
      },
      onAdDisplayedCallback: (ad) {
        toast('Rewarded ad loaded from ${ad.networkName}');
      },
      onAdDisplayFailedCallback: (ad, error) {
        toast(error.message.toString());
      },
      onAdClickedCallback: (ad) {
        toast('Ad Clicked');
      },
      onAdHiddenCallback: (ad) {
        toast('Ad Hidden');
      },
      onAdReceivedRewardCallback: (ad, reward) async {

        }

    ));
  }

  void showAds2() async {
    final String rewardedAdUnitId =  Platform.isAndroid ?await DataBase().retrieveString('applovinRewardedAdAndroid') ?? "b6a2ecde63205294" : await DataBase().retrieveString('applovinRewardedAdIos') ?? "b6a2ecde63205294";

    bool isReady = (await AppLovinMAX.isRewardedAdReady(rewardedAdUnitId))!;
    if (isReady) {
      initializeRewardedAds2();
      AppLovinMAX.showRewardedAd(rewardedAdUnitId);
      loadAds();
    }else{
      loadAds();
    }
  }

}