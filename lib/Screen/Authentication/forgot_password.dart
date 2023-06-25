import 'package:cash_rocket/Repositories/authentication_repo.dart';
import 'package:cash_rocket/Screen/Constant%20Data/button_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import '../Constant Data/constant.dart';
import '../Home Screen/no_internet_screen.dart';
import 'otp_verify.dart';

class ForGotPassWord extends StatefulWidget {
  const ForGotPassWord({Key? key}) : super(key: key);

  @override
  State<ForGotPassWord> createState() => _ForGotPassWordState();
}

class _ForGotPassWordState extends State<ForGotPassWord> {


  TextEditingController emailEditingController = TextEditingController();


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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(lang.S.of(context).resetPassword,style: kTextStyle.copyWith(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: const AssetImage('images/bg.png'),
            width: context.width(),
            height: context.height(),
            fit: BoxFit.cover,
          ),

          Container(
            padding: const EdgeInsets.all(10.0),
            height: context.height() / 3.0,
            width: context.width() / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                RichText(
                  text: TextSpan(
                    text:
                        lang.S.of(context).pleaseEnterYourAddressbelow,
                    style: kTextStyle.copyWith(color: kTitleColor),
                    children: [
                      TextSpan(
                        text: lang.S.of(context).password,
                        style: kTextStyle.copyWith(color: kMainColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                AppTextField(
                  showCursor: false,
                  textFieldType: TextFieldType.EMAIL,
                  controller: emailEditingController,
                  decoration: kInputDecoration.copyWith(
                    labelText: lang.S.of(context).email,
                    labelStyle:
                        kTextStyle.copyWith(color: kTitleColor),
                    hintText: lang.S.of(context).enterYourRegistrationEmail,
                    hintStyle:
                        kTextStyle.copyWith(color: kGreyTextColor),
                  ),
                ),
                const SizedBox(height: 20.0),
                ButtonGlobal(
                    buttontext: lang.S.of(context).continu,
                    buttonDecoration: kButtonDecoration,
                    onPressed: () async{
                      try{
                        EasyLoading.show(status: 'Sending Otp');
                        var response = await AuthRepo().resetPasswordWithEmail(emailEditingController.text);
                        if(response && mounted){
                          const OtpVerify().launch(context);
                          EasyLoading.showSuccess('Otp sent. Please check your email');
                        }else{
                          EasyLoading.showError('Please Try Again');
                        }
                      }catch(e){
                        EasyLoading.showError(e.toString());
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
