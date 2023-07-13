import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vungle/vungle.dart';

import '../../Model/purchase_model.dart';
import '../../Repositories/rewards_repo.dart';

class VungleAd {
  String? appId;
  String? placementId;
  bool sdkInit = false;
  bool adLoaded = false;
  String sdkVersion = "";


  void loadVungle() {
    if (Platform.isAndroid) {
      appId = '64adc886847c940a560e597a';
      placementId = 'DEFAULT-1975454';
      Vungle.init(appId!);
    } else {
     /* appId = '62dcea4266c52ee961b451df';
      placementId = 'ROCKET-8900187';
      Vungle.init(appId!);

      */
    }
    Vungle.loadAd(placementId!);
    onPlayAd();
  }

  void onPlayAd() async {
    if (await Vungle.isAdPlayable('DEFAULT-1975454')) {
      Vungle.playAd('DEFAULT-1975454');

      Vungle.onAdRewardedListener = (placementId) async {
        try {
          EasyLoading.show(status: 'Getting rewards');
          bool isValid = await PurchaseModel().isActiveBuyer();
          if (isValid) {
            var response = await RewardRepo().addPoint('10', 'Vungle Video Ads');
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
      };
    } else {
      if (kDebugMode) {
        print('Ad is not ready');
      }
    }
  }

  void loadVungle2() {
    if (Platform.isAndroid) {
      appId = '64adc886847c940a560e597a';
      placementId = 'REWARD_AT_LOSE-6004691';
      Vungle.init(appId!);
    } else {
      /* appId = '62dcea4266c52ee961b451df';
      placementId = 'ROCKET-8900187';
      Vungle.init(appId!);

      */
    }
    Vungle.loadAd(placementId!);
    onPlayAd();
  }

  void onPlayAd2() async {
    if (await Vungle.isAdPlayable('REWARD_AT_LOSE-6004691')) {
      Vungle.playAd('REWARD_AT_LOSE-6004691');

    } else {
      if (kDebugMode) {
        print('Ad is not ready');
      }
    }
  }


}
