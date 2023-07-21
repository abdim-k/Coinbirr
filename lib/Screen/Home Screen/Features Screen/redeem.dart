// ignore_for_file: unused_result

import 'package:cash_rocket/Model/user_profile_model.dart';
import 'package:cash_rocket/Model/withdraw_method_model.dart';
import 'package:cash_rocket/Repositories/withdraw_repo.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import '../../../Model/purchase_model.dart';
import '../../../Model/withdraw_currency_convert_model.dart';
import '../../../Provider/database_provider.dart';
import '../../../Provider/profile_provider.dart';
import '../../Constant Data/button_global.dart';
import '../../Constant Data/constant.dart';
import '../home.dart';
import '../no_internet_screen.dart';

class Redeem extends StatefulWidget {
  const Redeem({Key? key}) : super(key: key);

  @override
  State<Redeem> createState() => _RedeemState();
}

class _RedeemState extends State<Redeem> {
  List<String> logoList = [
    'images/paypal.png',
    'images/bkash.png',
    'images/paytm.png',
    'images/stripe.png',
  ];
  List<String> bgList = [
    'images/bg3.png',
    'images/bg1.png',
    'images/bg4.png',
    'images/bg2.png',
  ];

  List<String> bankList = [
    'PayPal',
    'bkash',
    'Paytm',
    'Stripe',
  ];

  List<String> listTitle = [
    'Minimum 1000 Points',
    'Minimum 1000 Points',
    'Minimum 1000 Points',
    'Minimum 1000 Points',
  ];

  bool isBalanceShow = false;
  int methodId = 0;
  int currencyId = 0;
  double minimumAMount = 0;
  TextEditingController coinsController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result && mounted) {
      NoInternetScreen(screenName: widget).launch(context);
    }
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, watch) {
      AsyncValue<UserProfileModel> profileInfo =
          ref.watch(personalProfileProvider);
      AsyncValue<WithdrawMethodModel> withdrawInfo =
          ref.watch(withdrawMethodProvider);
      AsyncValue<WithdrawCurrencyConvertModel> currencyInfo =
          ref.watch(withdrawCurrencyProvider);
      return profileInfo.when(data: (info) {
        return Scaffold(
          backgroundColor: Colors.white,
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
              lang.S.of(context).redeem,
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
                      )),
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
                          ? info.data?.user?.wallet?.balance.toString() ?? '0'
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
            onRefresh: () async => ref.refresh(withdrawMethodProvider),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    withdrawInfo.when(data: (info) {
                      return HorizontalList(
                          padding: EdgeInsets.zero,
                          spacing: 10.0,
                          itemCount: info.data?.withdrawMethod?.length ?? 0,
                          itemBuilder: (_, i) {
                            return Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Container(
                                  height: 115,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: DecorationImage(
                                        image: AssetImage(bgList[i % 4]),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 20.0,
                                            backgroundImage: NetworkImage(
                                              info.data?.withdrawMethod?[i]
                                                      .image ??
                                                  'https://cdn-icons-png.flaticon.com/512/888/888871.png',
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 80.0,
                                          ),
                                          Transform.scale(
                                                  scaleX: 3.0,
                                                  scaleY: 3.0,
                                                  child: const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 12.0,
                                                  ))
                                              .visible(methodId ==
                                                  info.data!.withdrawMethod![i]
                                                      .id!),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      SizedBox(
                                        width: 140,
                                        child: Text(
                                          info.data?.withdrawMethod?[i].name ??
                                              'Not Defined',
                                          style: kTextStyle.copyWith(
                                            color: Colors.white,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        '${info.data?.withdrawMethod?[i].minimumAmount ?? '0'}(minimum)',
                                        style: kTextStyle.copyWith(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ).onTap(() {
                              setState(() {
                                methodId = int.parse(info
                                    .data!.withdrawMethod![i].id
                                    .toString());
                                minimumAMount = double.tryParse(info
                                        .data!.withdrawMethod![i].minimumAmount
                                        .toString()) ??
                                    0.0;
                              });
                            });
                          });
                    }, error: (e, stack) {
                      return Center(
                        child: Text(e.toString()),
                      );
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }),
                    const SizedBox(height: 20.0),
                    currencyInfo.when(data: (currency) {
                      return HorizontalList(
                          itemCount:
                              currency.data?.currencyConvertInfo?.length ?? 0,
                          itemBuilder: (_, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(color: kTitleColor)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          '${currency.data?.currencyConvertInfo?[index].currency?.symbol ?? ''} ${currency.data?.currencyConvertInfo?[index].currency?.isoCode ?? ''} (${currency.data?.currencyConvertInfo?[index].currency?.name ?? ''})'),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ).visible(currencyId ==
                                          currency.data!
                                              .currencyConvertInfo![index].id!)
                                    ],
                                  ),
                                ).onTap(() {
                                  setState(() {
                                    currencyId = int.parse(currency.data
                                            ?.currencyConvertInfo?[index].id
                                            .toString() ??
                                        '0');
                                  });
                                }),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text('${currency.data?.currencyConvertInfo?[index].parCurrency ?? ''} ${currency.data?.currencyConvertInfo?[index].currency?.isoCode ?? ''} = ${currency.data?.currencyConvertInfo?[index].coin ?? ''} coins')
                                    .visible(currencyId ==
                                        currency.data!
                                            .currencyConvertInfo![index].id!)
                              ],
                            );
                          });
                    }, error: (e, stack) {
                      return Center(
                        child: Text(e.toString()),
                      );
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }),
                    const SizedBox(height: 10.0),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                              color: kGreyTextColor.withOpacity(0.1),
                              width: 1.0)),
                      child: AppTextField(
                        cursorColor: kMainColor,
                        textFieldType: TextFieldType.NAME,
                        textAlign: TextAlign.start,
                        controller: coinsController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 25),
                          border: InputBorder.none,
                          hintText: lang.S.of(context).enterCoinAmount,
                          hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                              color: kGreyTextColor.withOpacity(0.1),
                              width: 1.0)),
                      child: AppTextField(
                        cursorColor: kMainColor,
                        textFieldType: TextFieldType.NAME,
                        controller: accountController,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 25),
                          border: InputBorder.none,
                          hintText: lang.S.of(context).withdrawAccount,
                          hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ButtonGlobal(
                      buttontext: lang.S.of(context).withdraw,
                      buttonDecoration: kButtonDecoration,
                      onPressed: (() async {
                        if (methodId == 0 && currencyId == 0) {
                          EasyLoading.showError(
                              'Please Select Withdraw Method and Currency');
                        } else if (coinsController.text.isEmpty) {
                          EasyLoading.showError('Please Enter the amount');
                        } else if (accountController.text.isEmpty) {
                          EasyLoading.showError(
                              'Please Enter the withdraw account');
                        } else if (coinsController.text.toDouble() <
                            minimumAMount) {
                          EasyLoading.showError(
                              'Minimum withdraw balance is $minimumAMount');
                        } else if (info.data!.user!.wallet!.balance!.toInt() <
                            coinsController.text.toInt()) {
                          EasyLoading.showError('Not Enough Balance');
                        } else {
                          try {
                            EasyLoading.show(status: 'Requesting Withdraw');
                            bool isValid =
                                await PurchaseModel().isActiveBuyer();
                            if (isValid) {
                              var status = await WithdrawRepo()
                                  .withdrawRequestInfo(
                                      methodId.toString(),
                                      currencyId.toString(),
                                      coinsController.text,
                                      accountController.text);
                              if (status && mounted) {
                                EasyLoading.showSuccess(
                                    'Withdraw requested Successfully');
                                ref.refresh(personalProfileProvider);
                                const Home().launch(context);
                              } else {
                                EasyLoading.showError('Error Occurred');
                              }
                            } else {
                              // ignore: use_build_context_synchronously
                              showLicense(context: context);
                            }
                          } catch (e) {
                            EasyLoading.showError(e.toString());
                          }
                        }
                      }),
                    ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [

                    SizedBox(width: 8),
                    Text(
                      "Attention: Withdrawal Limits \n \nየ Coin መጠን 1000 ወይም ከዚያ በላይ በሚሆንበት ጊዜ ብቻ ማውጣት ይችላሉ። \n \n እባኮትን Withdraw ከማድረግዎ በፊት የሚፈለገውን የ Coin ቀሪ ሂሳብ ማሟላትዎን ያረጋግጡ።",


                      style: TextStyle(
                        color: Colors.black, // Customize the text color as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

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
        return const CircularProgressIndicator();
      });
    });
  }
}
