
import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Provider/database_provider.dart';
import '../../Repositories/rewards_repo.dart';




class FacebookRewardVideoAd {

  bool _isRewardedAdLoaded = false;
 
  void loadRewardedVideoAd() async{

    final String rewardedAdUnitId =  Platform.isAndroid ?await DataBase().retrieveString('audienceNetworkRewardedAdAndroid') ?? "VID_HD_9_16_39S_APP_INSTALL" : await DataBase().retrieveString('audienceNetworkAdIos') ?? "VID_HD_9_16_39S_APP_INSTALL";


    FacebookAudienceNetwork.init(
      testingId: "a77955ee-3304-4635-be65-81029b0f5201",
      iOSAdvertiserTrackingEnabled: true,
    );
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: rewardedAdUnitId,
      listener: (result, value) async {
        if (result == RewardedVideoAdResult.LOADED) {
          _isRewardedAdLoaded = true;
        }
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
          try{
            EasyLoading.show(status: 'Getting rewards');
            var response = await RewardRepo().addPoint('10', 'Admob Video Ads');
            if(response){
              EasyLoading.showSuccess('You Have Earned 10 Coins');
            }else{
              EasyLoading.showError('Error Happened. Try Again');
            }
          }catch(e){
            EasyLoading.showError(e.toString());
          }
        }
          /// Once a Rewarded Ad has been closed and becomes invalidated,
          /// load a fresh Ad by calling this function.
          if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
              (value == true || value["invalidated"] == true)) {
            _isRewardedAdLoaded = false;
            loadRewardedVideoAd();
          }
      },
    );
  }

  void showRewardedAd() {
    if (_isRewardedAdLoaded == true) {
      FacebookRewardedVideoAd.showRewardedVideoAd();
    } else {
      toast('Ad Not available');
    }
    loadRewardedVideoAd();
  }

}