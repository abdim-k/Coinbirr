// ignore_for_file: use_build_context_synchronously

import 'package:cash_rocket/Provider/database_provider.dart';
import 'package:cash_rocket/Screen/Constant%20Data/constant.dart';
import 'package:cash_rocket/Screen/Home%20Screen/home.dart';
import 'package:cash_rocket/Screen/Home%20Screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Model/purchase_model.dart';
import '../../Repositories/authentication_repo.dart';
import '../../Repositories/rewards_repo.dart';
import 'on_board.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    defaultBlurRadius = 10.0;
    defaultSpreadRadius = 0.5;
    String token = await DataBase().retrieveString('token') ?? '';
    bool result = await InternetConnectionChecker().hasConnection;

    if (result) {
      bool isValid = await PurchaseModel().isActiveBuyer();
      if (isValid) {
        if (token != '') {
          bool ads = await RewardRepo().getAdNetWorks();
          bool status = await AuthRepo().updateToken();
          if (status || ads) {
            const Home().launch(context, isNewTask: true);
          } else {
            const OnBoard().launch(context, isNewTask: true);
          }
        } else {
          const OnBoard().launch(context, isNewTask: true);
        }
      } else {
        showLicense(context: context);
      }
    } else {
      const NoInternetScreen(
        screenName: SplashScreen(),
      ).launch(context);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.center, children: [
            Image(
              image: const AssetImage('images/bg1.jpg'),
              width: context.width(),
              height: context.height(),
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                children: [
                  const Image(
                    image: AssetImage('images/logo.png'),
                  ),
                  Text(
                    'Coinbirr',
                    style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                  )
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}