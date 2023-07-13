import 'package:applovin_max/applovin_max.dart';
import 'package:cash_rocket/Screen/Home%20Screen/Features%20Screen/Quiz/mt_football.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../Model/quiz_model.dart';
import '../../../../Repositories/rewards_repo.dart';
import '../../../../Videos/AppLovin/applovin.dart';
import '../../../../Videos/Vungle/vungle.dart';
import '../../../Constant Data/constant.dart';
import '../../home.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;

class MtLoser extends StatefulWidget {
  const MtLoser({Key? key, required this.quizzes, required this.score})
      : super(key: key);
  final Quizzes quizzes;
  final String score;
  @override
  State<MtLoser> createState() => _MtLoserState();
}

class _MtLoserState extends State<MtLoser> {
  AppLovin appLovin = AppLovin();

  void initialization() async {
    await AppLovinMAX.initialize(sdkKey);
  }

  @override
  void initState() {

    initialization();
    //   facebookRewardVideoAd.loadRewardedVideoAd();
    //  admob.createRewardedAd();

    appLovin.loadAds();
    super.initState();
  }

    void showPopUp(String retakePoint) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 320,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    lang.S.of(context).areYouAgree,
                    style: kTextStyle.copyWith(
                        color: kTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'If you retake then $retakePoint points will be deducted!',
                    style: kTextStyle.copyWith(color: kGreyTextColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    height: 150,
                    width: 140,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/coin.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: kMainColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                lang.S.of(context).yes,
                                style: kTextStyle.copyWith(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ).onTap(() async {
                            try {
                              EasyLoading.show(status: 'Loading');
                              bool status = await RewardRepo().removePoint(
                                  retakePoint, 'Paid For Quiz Retake');
                              if (status && mounted) {
                                EasyLoading.showSuccess('Successful');
                                MtFootball(
                                  quizzes: widget.quizzes,
                                ).launch(context);
                              } else {
                                EasyLoading.showError('Not Enough Coin');
                              }
                            } catch (e) {
                              EasyLoading.showError(e.toString());
                            }
                          }),
                        ),
                        const SizedBox(width: 5.0),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: kGreyTextColor.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.transparent),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                lang.S.of(context).No,
                                style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ).onTap(() => finish(context)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final InAppReview _inAppReview = InAppReview.instance;
  String select = 'com.pioneerdev.coinbirr';

  List<String> option = [
    'Share Score',
    'Rate Us',
    'Home',
  ];


  void review() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
    } else {
      toast('Review Not Available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  lang.S.of(context).sorry,
                  style: kTextStyle.copyWith(color: kGreyTextColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5.0),
                Text(
                  lang.S.of(context).youLose,
                  style: kTextStyle.copyWith(
                      color: kTitleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 170,
                  width: 170,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/lose.png'),
                    ),
                  ),
                ),
                Text(
                  'Loser',
                  style: kTextStyle.copyWith(
                      color: kTitleColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: const Color(0xFF8555EA),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(FeatherIcons.check,
                                    size: 16.0, color: Colors.white),
                                const SizedBox(width: 4.0),
                                Text(
                                  '${widget.score}/${widget.quizzes.questions!.length}',
                                  style:
                                      kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: const Color(0xFF2F81E8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(FeatherIcons.x,
                                    color: Colors.white, size: 16.0),
                                const SizedBox(width: 4.0),
                                Text(
                                  '${widget.quizzes.questions!.length - widget.score.toInt()}/${widget.quizzes.questions!.length}',
                                  style:
                                      kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CircularPercentIndicator(
                        radius: 40.0,
                        progressColor: kMainColor,
                        circularStrokeCap: CircularStrokeCap.round,
                        lineWidth: 5.0,
                        animation: true,
                        percent: (widget.score.toInt() /
                            widget.quizzes.questions!.length),
                        center: Text(
                          "${((widget.score.toInt() / widget.quizzes.questions!.length) * 100).toInt()}%",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: const Color(0xFFFF8244),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(FeatherIcons.award,
                                    color: Colors.white, size: 16.0),
                                const SizedBox(width: 4.0),
                                Text(
                                  widget.quizzes.rewardPoint.toString(),
                                  style:
                                      kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: const Color(0xFF4EB000),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(FeatherIcons.database,
                                    color: Colors.white, size: 16.0),
                                const SizedBox(width: 4.0),
                                Text(
                                  widget.quizzes.questions!.length.toString(),
                                  style:
                                      kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Card(
                  elevation: 1.0,
                  color: kMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ListTile(
                    onTap: (() =>
                        showPopUp(widget.quizzes.retakePoint.toString())),
                    title: Text(
                      lang.S.of(context).playAgain,
                      textAlign: TextAlign.center,
                      style: kTextStyle.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Card(
                  elevation: 1.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      Share.share('I have earned \$10 in a day. Use my refer code to earn \$10 on signup. . Download the app now and start your journey of making money online: https://play.google.com/store/apps/details?id=com.pioneerdev.coinbirr&pli=1',
                          subject: 'Look what I made answering simple quiz about Ethiopia');
                    },
                    title: Text(
                      lang.S.of(context).shareSqure,
                      textAlign: TextAlign.center,
                      style: kTextStyle.copyWith(
                          color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Card(
                  elevation: 1.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ListTile(
                    onTap: (() => review),
                    title: Text(
                      lang.S.of(context).rateUs,
                      textAlign: TextAlign.center,
                      style: kTextStyle.copyWith(
                          color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Card(
                  elevation: 1.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        appLovin.showAds2();
                        const Home().launch(context);
                      });
                    },
                    title: Text(
                      lang.S.of(context).home,
                      textAlign: TextAlign.center,
                      style: kTextStyle.copyWith(
                          color: kTitleColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
