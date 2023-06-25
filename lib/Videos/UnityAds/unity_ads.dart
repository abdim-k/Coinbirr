// ignore_for_file: avoid_print
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../../Model/purchase_model.dart';
import '../../Provider/profile_provider.dart';
import '../../Repositories/rewards_repo.dart';

class AdManager {
  Future<void> loadUnityAd() async {
    await UnityAds.load(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }
  static Future<void> showIntAd({required WidgetRef ref}) async {
    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) async {
        try {
          EasyLoading.show(status: 'Getting rewards');
          bool isValid = await PurchaseModel().isActiveBuyer();
          if (isValid) {
            var response = await RewardRepo().addPoint('10', 'Unity Video Ads');
            if (response) {
              EasyLoading.showSuccess('You Have Earned 10 Coins');
              ref.refresh(personalProfileProvider);
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
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }

  Future<void> loadUnityAd2() async {
    await UnityAds.load(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  static Future<void> showIntAd2() async {
    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) => print('Video Ad $placementId completed'),
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }

  Future<void> loadUnityAd3() async {
    await UnityAds.load(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }
  static Future<void> showIntAd3({required WidgetRef ref}) async {
    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) async {
        try {
          EasyLoading.show(status: 'Getting rewards');
          bool isValid = await PurchaseModel().isActiveBuyer();
          if (isValid) {
            var response = await RewardRepo().addPoint('10', 'Unity Video Ads');
            if (response) {
              EasyLoading.showSuccess('You Have Earned 10 Coins');
              ref.refresh(personalProfileProvider);
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
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }


}