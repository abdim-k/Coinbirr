import 'package:cash_rocket/Repositories/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import '../Constant Data/button_global.dart';
import '../Constant Data/constant.dart';
import 'log_in.dart';


class OtpVerify extends StatefulWidget {
  const OtpVerify({Key? key}) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {

  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  late FocusNode pin5FocusNode;
  late FocusNode pin6FocusNode;

  bool isVerified = false;
  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController pin3Controller = TextEditingController();
  TextEditingController pin4Controller = TextEditingController();
  TextEditingController pin5Controller = TextEditingController();
  TextEditingController pin6Controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }
  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(lang.S.of(context).otpVerify,style: kTextStyle.copyWith(color: Colors.white),),
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
            width: context.width() / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10.0),
                RichText(
                  text: TextSpan(
                    text:
                    lang.S.of(context).pleaseResetYOurCode,
                    style: kTextStyle.copyWith(color: kTitleColor),
                    children: [
                      TextSpan(
                        text: lang.S.of(context).password,
                        style: kTextStyle.copyWith(color: kMainColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 50.0,
                                  child: TextFormField(
                                    autofocus: true,
                                    controller: pin1Controller,
                                    obscureText: true,
                                    style: const TextStyle(fontSize: 24),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: otpInputDecoration,
                                    onChanged: (value) {
                                      nextField(value, pin2FocusNode);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                  child: TextFormField(
                                    focusNode: pin2FocusNode,
                                    obscureText: true,
                                    controller: pin2Controller,
                                    style: const TextStyle(fontSize: 24),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: otpInputDecoration,
                                    onChanged: (value) => nextField(value, pin3FocusNode),
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                  child: TextFormField(
                                    focusNode: pin3FocusNode,
                                    controller: pin3Controller,
                                    obscureText: true,
                                    style: const TextStyle(fontSize: 24),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: otpInputDecoration,
                                    onChanged: (value) => nextField(value, pin4FocusNode),
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                  child: TextFormField(
                                    focusNode: pin4FocusNode,
                                    controller: pin4Controller,
                                    obscureText: true,
                                    style: const TextStyle(fontSize: 24),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: otpInputDecoration,
                                    onChanged: (value) => nextField(value, pin5FocusNode),
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                  child: TextFormField(
                                    focusNode: pin5FocusNode,
                                    obscureText: true,
                                    controller: pin5Controller,
                                    style: const TextStyle(fontSize: 24),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: otpInputDecoration,
                                    onChanged: (value) => nextField(value, pin6FocusNode),
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                  child: TextFormField(
                                    focusNode: pin6FocusNode,
                                    controller: pin6Controller,
                                    obscureText: true,
                                    style: const TextStyle(fontSize: 24),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: otpInputDecoration,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        pin6FocusNode.unfocus();
// Then you need to check is the code is correct or not
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonGlobal(
                          buttontext: lang.S.of(context).otpVerify,
                          buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                          onPressed: () async {
                            if (pin1Controller.text.isEmpty ||
                                pin2Controller.text.isEmpty ||
                                pin3Controller.text.isEmpty ||
                                pin4Controller.text.isEmpty ||
                                pin5Controller.text.isEmpty ||
                                pin6Controller.text.isEmpty) {
                              toast('Please Enter Your OTP');
                            } else {
                              try {
                                EasyLoading.show(status: 'Verifying OTP');
                                String code = pin1Controller.text +pin2Controller.text +pin3Controller.text +pin4Controller.text +pin5Controller.text +pin6Controller.text;
                                var response = await AuthRepo().verifyOtp(code);
                                if (response) {
                                  setState(() {
                                    isVerified = true;
                                  });
                                  EasyLoading.showSuccess('OTP Verified');
                                } else {
                                  EasyLoading.showError('Please check your otp');
                                }
                              } catch (e) {
                                EasyLoading.showError(e.toString());
                              }
                            }
                          }),
                    ),

                  ],
                ).visible(!isVerified),
                Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: lang.S.of(context).reEnterPassword,
                          labelStyle: kTextStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                            borderSide: BorderSide(color: kMainColor),
                          ),
                          hintText: '****************',
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                            borderSide: BorderSide(
                              color: kBorderColorTextField,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: lang.S.of(context).reEnterPassword,
                          labelStyle: kTextStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                            borderSide: BorderSide(color: kMainColor),
                          ),
                          hintText: '***********',
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                            borderSide: BorderSide(
                              color: kBorderColorTextField,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonGlobal(
                          buttontext: 'Reset Password',
                          buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                          onPressed: () async {
                            if (passwordController.text.isEmpty ||
                                confirmPasswordController.text.isEmpty ) {
                              toast('Please Enter Your OTP');
                            } else if(passwordController.text != confirmPasswordController.text){
                              toast('Your Password Doesn\'t match');
                            } else {
                              try {
                                EasyLoading.show(status: 'Resetting Password');
                                String code = pin1Controller.text +pin2Controller.text +pin3Controller.text +pin4Controller.text +pin5Controller.text +pin6Controller.text;
                                var response = await AuthRepo().resetPassword(code,passwordController.text);
                                if (response && mounted) {
                                  EasyLoading.showSuccess('Password Reset Successfully');
                                  const LogIn().launch(context,isNewTask: true);
                                } else {
                                  EasyLoading.showError('Error Happened');
                                }
                              } catch (e) {
                                EasyLoading.showError(e.toString());
                              }
                            }
                          }),
                    ),
                  ],
                ).visible(isVerified),
                const SizedBox(height: 20.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
