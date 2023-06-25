import 'package:cash_rocket/Screen/Authentication/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Provider/database_provider.dart';
import '../../Repositories/authentication_repo.dart';
import '../Constant Data/button_global.dart';
import '../Constant Data/constant.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Change Password',
          style: kTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              AppTextField(
                showCursor: false,
                textFieldType: TextFieldType.PASSWORD,
                controller: passwordEditingController,
                decoration: kInputDecoration.copyWith(
                  labelText: 'New Password',
                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                  hintText: 'Enter Your New Password',
                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                ),
              ),
              const SizedBox(height: 15.0),
              AppTextField(
                showCursor: false,
                textFieldType: TextFieldType.PASSWORD,
                controller: confirmPasswordEditingController,
                decoration: kInputDecoration.copyWith(
                  labelText: 'Confirm Password',
                  labelStyle: kTextStyle.copyWith(color: kTitleColor),
                  hintText: 'Enter Your Password Again',
                  hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                ),
              ),
              const SizedBox(height: 15.0),
              ButtonGlobal(
                buttontext: 'Update Password',
                buttonDecoration: kButtonDecoration,
                onPressed: () async{
                  if(passwordEditingController.text.isEmpty){
                    EasyLoading.showError('Password can\'t be empty');
                  } else if(passwordEditingController.text.length < 6){
                    EasyLoading.showError('Password can\'t be less than 6 character');
                  } else if(passwordEditingController.text != confirmPasswordEditingController.text){
                    EasyLoading.showError('Password doesn\'t match');
                  } else{
                    try{
                      EasyLoading.show(status: 'Updating Password');
                      var response = await AuthRepo().updatePassword(passwordEditingController.text);
                      if(response){
                        var response = await AuthRepo().logOut();
                        if (response && mounted) {
                          DataBase().saveString('', 'token');
                          const LogIn().launch(context, isNewTask: true);
                          EasyLoading.showSuccess('Password Update Successful');
                        } else {
                          EasyLoading.showError('Please Try Again');
                        }
                      }else{
                        EasyLoading.showError('Error Happened. Try again');
                      }
                    }catch(e){
                      EasyLoading.showError(e.toString());
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
