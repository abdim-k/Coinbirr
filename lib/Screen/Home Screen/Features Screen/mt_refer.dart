import 'package:cash_rocket/Screen/Constant%20Data/constant.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Refer extends StatefulWidget {
  const Refer({Key? key}) : super(key: key);

  @override
  State<Refer> createState() => _ReferState();
}

class _ReferState extends State<Refer> with TickerProviderStateMixin {
  late AnimationController _glitchController;
  late Animation<Offset> _glitchAnimation;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _glitchAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.1, 0.1),
    ).animate(
      CurvedAnimation(parent: _glitchController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glitchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('images/bg.png'),
            // Replace with your background image
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: SlideTransition(
              position: _glitchAnimation,
              child: Container(
                color: Colors.green, // Replace with your desired glitch color
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Service Disabled',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'We are sorry, but the refer service is currently disabled for maintenance and to prevent fraud. We are working on fixing the issues and will bring back the service soon. Thank you for your understanding.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate back to the Home screen
                        Navigator.pop(context);

                      },
                      style: ElevatedButton.styleFrom(
                        primary: kMainColor, // Button background color
                        onPrimary: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text('Back to Home'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
import 'package:cash_rocket/Model/user_profile_model.dart';
import 'package:cash_rocket/Screen/Constant%20Data/button_global.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import '../../../Provider/database_provider.dart';
import '../../../Provider/profile_provider.dart';
import '../../Authentication/log_in.dart';
import '../../Constant Data/constant.dart';
import '../no_internet_screen.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;



class Refer extends StatefulWidget {
  const Refer({Key? key}) : super(key: key);

  @override
  State<Refer> createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  final TextEditingController _textController = TextEditingController(text: '5FLK2M');

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _textController.text));
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Invitation Code Copied'),
    ));
  }

  bool isBalanceShow = false;

  bool isChecked = true;

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            lang.S.of(context).refer,
            style: kTextStyle.copyWith(color: Colors.white),
          ),
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
            Consumer(builder: (_, ref, watch) {
              AsyncValue<UserProfileModel> referCode = ref.watch(personalProfileProvider);
              return referCode.when(data: (code) {
                if (code.data?.user?.status == 0) {
                  EasyLoading.showError('You Are Disable!');
                  DataBase().deleteToken();
                  const LogIn().launch(context, isNewTask: true);
                }

                return Container(
                  padding: const EdgeInsets.all(20.0),
                  height: context.height() / 1.5,
                  width: context.width() / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.S.of(context).inviteYourFriends,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          lang.S.of(context).inviteYourFriendtoUseCashRockett,
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                          maxLines: 5,
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          height: 235,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/refferbanner1.png'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0), side: BorderSide(color: kGreyTextColor.withOpacity(0.1), width: 1.0)),
                          child: AppTextField(
                            readOnly: true,
                            textFieldType: TextFieldType.NAME,
                           initialValue: code.data?.user?.referCode ?? '',
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: code.data?.user?.referCode ?? '',
                                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                suffixIcon: const Icon(FeatherIcons.copy, color: kMainColor).onTap(() {
                                  setState(() {
                                    _copyToClipboard();
                                  });
                                })),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ButtonGlobal(
                          buttontext: lang.S.of(context).inviteNow,
                          buttonDecoration: kButtonDecoration,
                          onPressed: (() => Share.share('I have earned \$10 in a day. Use my refer code to earn \$10 on signup. My Refer Code is ${code.data?.user?.referCode ?? ''}. Download the app now and start your journey of making money online: https://play.google.com/store/apps/details?id=com.pioneerdev.coinbirr&pli=1')),
                        ),

                      ],
                    ),
                  ),
                );
              }, error: (e, stack) {
                return Center(
                  child: Text(e.toString()),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
            }),
          ],
        ),
      ),
    );
  }
}

 */
