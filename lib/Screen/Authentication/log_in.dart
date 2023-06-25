import 'package:cash_rocket/Provider/database_provider.dart';
import 'package:cash_rocket/Repositories/authentication_repo.dart';
import 'package:cash_rocket/Screen/Authentication/forgot_password.dart';
import 'package:cash_rocket/Screen/Authentication/sign_up.dart';
import 'package:cash_rocket/Screen/Constant%20Data/button_global.dart';
import 'package:cash_rocket/Screen/Home%20Screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Repositories/rewards_repo.dart';
import '../Constant Data/constant.dart';
import '../Home Screen/no_internet_screen.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isChecked = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: const AssetImage('images/bg.png'),
              width: context.width(),
              height: context.height(),
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: context.width() / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/cash.png'),
                            ),
                          ),
                        ),
                        Text(
                          lang.S.of(context).cashRocket,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40.0),
                        AppTextField(
                          showCursor: true,
                          textFieldType: TextFieldType.EMAIL,
                          controller: emailController,
                          decoration: kInputDecoration.copyWith(
                            labelText: lang.S.of(context).email,
                            labelStyle: kTextStyle.copyWith(color: kTitleColor),
                            hintText: lang.S.of(context).enterYourAddress,
                            hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        AppTextField(
                          showCursor: true,
                          textStyle: kTextStyle.copyWith(color: kTitleColor),
                          cursorColor: kTitleColor,
                          controller: passwordController,
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: kInputDecoration.copyWith(
                            labelText: lang.S.of(context).password,
                            hintText: '********',
                            labelStyle: kTextStyle.copyWith(color: kTitleColor),
                            hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: kMainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  value: isChecked,
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        isChecked = val!;
                                      },
                                    );
                                  },
                                ),
                                Text(
                                  lang.S.of(context).rememberMe,
                                  style: kTextStyle.copyWith(color: kTitleColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Flexible(
                              child: Text(
                                lang.S.of(context).forgotPassword,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: kTextStyle.copyWith(color: kGreyTextColor),
                              ).onTap(
                                () => const ForGotPassWord().launch(context),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        ButtonGlobal(
                            buttontext: lang.S.of(context).logIn,
                            buttonDecoration: kButtonDecoration,
                            onPressed: () async {
                              if (emailController.text.isEmpty) {
                                EasyLoading.showInfo('Email Address is Required');
                              } else if (passwordController.text.isEmpty) {
                                EasyLoading.showInfo('Password is Required');
                              } else if (passwordController.text.length < 6) {
                                EasyLoading.showInfo('Password length must be at least 6 Character');
                              } else {
                                try {
                                  EasyLoading.show(status: 'Signing In');

                                  var response = await AuthRepo().signInWithEmail(emailController.text, passwordController.text);
                                  DataBase().saveString(response.data!.userId.toString(), 'userId');
                                  DataBase().saveString(response.data!.token.toString(), 'token');
                                  await RewardRepo().getAdNetWorks();
                                  if (mounted) {
                                    const Home().launch(context);
                                  }
                                  EasyLoading.showSuccess(response.message.toString());
                                } catch (e) {
                                  EasyLoading.showError(e.toString().replaceAll('Exception:', ''));
                                }
                              }
                            }),
                        const SizedBox(height: 20.0),
                        RichText(
                          text: TextSpan(
                            text: lang.S.of(context).havenotAnyAcconts,
                            style: kTextStyle.copyWith(color: kGreyTextColor),
                            children: [
                              TextSpan(
                                text: lang.S.of(context).signUp,
                                style: kTextStyle.copyWith(color: kMainColor),
                              ),
                            ],
                          ),
                        ).onTap(
                          () => const SignUp().launch(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
