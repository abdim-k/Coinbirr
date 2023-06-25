// ignore_for_file: unused_result

import 'package:cash_rocket/Provider/profile_provider.dart';
import 'package:cash_rocket/Screen/Constant%20Data/button_global.dart';
import 'package:cash_rocket/Screen/Constant%20Data/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key, required this.screenName}) : super(key: key);
  final Widget screenName;

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (_, ref, watch) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('images/nointernet.json'),
                const SizedBox(
                  height: 10.0,
                ),
                Text(lang.S.of(context).noInternetCollection, style: kTextStyle.copyWith(color: kTitleColor, fontSize: 20.0)),
                const SizedBox(
                  height: 10.0,
                ),
                ButtonGlobal(
                    buttontext: lang.S.of(context).tryAgain,
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () async{
                      ref.refresh(personalProfileProvider);
                      ref.refresh(quizProvider);
                      ref.refresh(withdrawHistoryProvider);
                      ref.refresh(userHistoryProvider);
                      ref.refresh(withdrawCurrencyProvider);
                      widget.screenName.launch(context);
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
