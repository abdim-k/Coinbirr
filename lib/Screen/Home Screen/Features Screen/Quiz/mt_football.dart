// ignore_for_file: use_build_context_synchronously

import 'package:applovin_max/applovin_max.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:cash_rocket/Model/quiz_model.dart';
import 'package:cash_rocket/Repositories/rewards_repo.dart';
import 'package:cash_rocket/Screen/Home%20Screen/Features%20Screen/Quiz/mt_loser.dart';
import 'package:cash_rocket/Screen/Home%20Screen/Features%20Screen/Quiz/mt_victory.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../Videos/AppLovin/applovin.dart';
import '../../../../Videos/UnityAds/unity_ads.dart';
import '../../../Constant Data/button_global.dart';
import '../../../Constant Data/config.dart';
import '../../../Constant Data/constant.dart';

class MtFootball extends StatefulWidget {
  const MtFootball({Key? key, required this.quizzes}) : super(key: key);
  final Quizzes quizzes;


  @override
  State<MtFootball> createState() => _MtFootballState();
}

class _MtFootballState extends State<MtFootball> {
  AppLovin appLovin = AppLovin();

  void initialization() async {
    await AppLovinMAX.initialize(sdkKey);
  }


  void showPopUp() {
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
                    '50/50',
                    style: kTextStyle.copyWith(
                        color: kTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    lang.S.of(context).amentMinim,
                    style: kTextStyle.copyWith(color: kGreyTextColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    height: 150,
                    width: 140,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/50.png'),
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
                          ).onTap(() => finish(context)),
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

  PageController pageController = PageController();

  bool isSelected = true;
  String select = '';
  int currentIndex = 0;
  List<String> option = ['Yes', 'No', 'None', 'Don\'t know'];
  int score = 0;

  void checkAnswer(String answer, String rightAnswer) {
    if (answer == rightAnswer) {
      score++;
    }
  }

  List<Color> colorList = [
    const Color(0xFFFF0000),
    const Color(0xFF4AAF4F),
    const Color(0xFFECECEC),
  ];
  final CountDownController _controller = CountDownController();
  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    initialization();
    //   facebookRewardVideoAd.loadRewardedVideoAd();
    //  admob.createRewardedAd();

    appLovin.loadAds();
    super.initState();

  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: const AssetImage('images/bg.png'),
                width: context.width(),
                height: context.height(),
                fit: BoxFit.cover,
              ),
              PageView.builder(
                  controller: pageController,
                  itemCount: widget.quizzes.questions!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (val) {
                    setState(() {
                      currentIndex++;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Column(
                      children: [
                        ListTile(
                          horizontalTitleGap: 0.0,
                          title: Text(
                            widget.quizzes.name ?? '',
                            style: kTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${widget.quizzes.questions!.length.toString()} Questions (${widget.quizzes.rewardPoint.toString()} Points)',
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                          trailing: CircularCountDownTimer(
                            duration: 30,
                            initialDuration: 0,
                            controller: _controller,
                            height: 50.0,
                            width: 50.0,
                            ringColor: Colors.grey[300]!,
                            ringGradient: null,
                            fillColor: Colors.white,
                            fillGradient: null,
                            backgroundColor: Colors.transparent,
                            backgroundGradient: null,
                            strokeWidth: 3.0,
                            strokeCap: StrokeCap.round,
                            textStyle: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                            textFormat: CountdownTextFormat.S,
                            isReverse: true,
                            isReverseAnimation: false,
                            isTimerTextShown: true,
                            autoStart: true,
                            onStart: () async {
                              //await Future.delayed(const Duration(seconds: 20)).then((value) => assetsAudioPlayer.open(Audio('images/tick.mp3'),autoStart: true,showNotification: false));
                            },
                            onChange: (val) {
                              if (val == '10') {
                                assetsAudioPlayer.open(Audio('images/tick.mp3'),
                                    autoStart: true, showNotification: false);
                              }
                            },
                            onComplete: () {
                              assetsAudioPlayer.dispose();
                              currentIndex + 1 ==
                                      widget.quizzes.questions!.length
                                  ? MtLoser(
                                      quizzes: widget.quizzes,
                                      score: score.toString(),
                                    ).launch(context)
                                  : pageController.nextPage(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.bounceIn,
                                    );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          width: context.width() / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image: NetworkImage(widget
                                          .quizzes.questions![i].image
                                          .toString()),
                                    ),
                                  ),
                                ).visible(widget.quizzes.questions![i].image !=
                                    Config.siteUrl),
                                const SizedBox(height: 10.0),
                                Center(
                                  child: Text(
                                    widget.quizzes.questions![i].question ?? '',
                                    style:
                                        kTextStyle.copyWith(color: kTitleColor),
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: select ==
                                                widget.quizzes.questions![i]
                                                    .optionA
                                            ? Colors.green
                                            : kGreyTextColor.withOpacity(0.5)),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      checkAnswer(
                                          "A",
                                          widget.quizzes.questions![i].answer
                                              .toString());
                                      setState(() {
                                        select = widget
                                            .quizzes.questions![i].optionA
                                            .toString();
                                      });
                                    },
                                    title: Text(
                                      widget.quizzes.questions![i].optionA ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: kTextStyle.copyWith(
                                        color: kTitleColor,
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            FeatherIcons.check,
                                            color: Colors.green,
                                          ).visible(select ==
                                              widget.quizzes.questions![i]
                                                  .optionA),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: select ==
                                                widget.quizzes.questions![i]
                                                    .optionB
                                            ? Colors.green
                                            : kGreyTextColor.withOpacity(0.5)),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      checkAnswer(
                                          "B",
                                          widget.quizzes.questions![i].answer
                                              .toString());

                                      setState(() {
                                        select = widget
                                            .quizzes.questions![i].optionB
                                            .toString();
                                      });
                                    },
                                    title: Text(
                                      widget.quizzes.questions![i].optionB ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: kTextStyle.copyWith(
                                        color: kTitleColor,
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            FeatherIcons.check,
                                            color: Colors.green,
                                          ).visible(select ==
                                              widget.quizzes.questions![i]
                                                  .optionB),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: select ==
                                                widget.quizzes.questions![i]
                                                    .optionC
                                            ? Colors.green
                                            : kGreyTextColor.withOpacity(0.5)),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      checkAnswer(
                                          "C",
                                          widget.quizzes.questions![i].answer
                                              .toString());

                                      setState(() {
                                        select = widget
                                            .quizzes.questions![i].optionC
                                            .toString();
                                      });
                                    },
                                    title: Text(
                                      widget.quizzes.questions![i].optionC ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: kTextStyle.copyWith(
                                        color: kTitleColor,
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            FeatherIcons.check,
                                            color: Colors.green,
                                          ).visible(select ==
                                              widget.quizzes.questions![i]
                                                  .optionC),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: select ==
                                                widget.quizzes.questions![i]
                                                    .optionD
                                            ? Colors.green
                                            : kGreyTextColor.withOpacity(0.5)),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      checkAnswer(
                                          "D",
                                          widget.quizzes.questions![i].answer
                                              .toString());

                                      setState(() {
                                        select = widget
                                            .quizzes.questions![i].optionD
                                            .toString();
                                      });
                                    },
                                    title: Text(
                                      widget.quizzes.questions![i].optionD ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: kTextStyle.copyWith(
                                        color: kTitleColor,
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            FeatherIcons.check,
                                            color: Colors.green,
                                          ).visible(select ==
                                              widget.quizzes.questions![i]
                                                  .optionD),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                ButtonGlobal(
                                    buttontext: lang.S.of(context).next,
                                    buttonDecoration: kButtonDecoration,
                                    onPressed: () async {

                                      assetsAudioPlayer.dispose();
                                      if (currentIndex + 1 ==
                                          widget.quizzes.questions!.length) {
                                        try {
                                          EasyLoading.show(status: 'Loading');
                                          var status = score ==
                                                  widget
                                                      .quizzes.questions!.length
                                              ? await RewardRepo().addQuizPoint(
                                                  widget.quizzes.rewardPoint
                                                      .toString(),
                                                  widget.quizzes.id.toString(),
                                                  '1',
                                                  '1')
                                              : await RewardRepo().addQuizPoint(
                                                  '0',
                                                  widget.quizzes.id.toString(),
                                                  '0',
                                                  '3');
                                          if (status) {
                                            appLovin.showInterstitialAd();
                                            EasyLoading.showSuccess(
                                                'Successful');
                                          } else {
                                            appLovin.showInterstitialAd();
                                            EasyLoading.showError(
                                                'Something went wrong');
                                          }
                                        } catch (e) {
                                          appLovin.showInterstitialAd();
                                          EasyLoading.showError(e.toString());
                                        }
                                      }
                                      currentIndex + 1 ==
                                              widget.quizzes.questions!.length
                                          ? score ==
                                                  widget
                                                      .quizzes.questions!.length
                                              ? Victory(

                                                  score: score.toString(),
                                                  questions: widget
                                                      .quizzes.questions!.length
                                                      .toString(),
                                                  point: widget
                                                      .quizzes.rewardPoint
                                                      .toString(),
                                                ).launch(context)
                                              : MtLoser(
                                                  quizzes: widget.quizzes,
                                                  score: score.toString(),
                                                ).launch(context)
                                          : pageController.nextPage(
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.bounceIn,
                                            );
                                    }),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: const Color(0xFFA86CD7),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              '50/50',
                                              style: kTextStyle.copyWith(
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ).onTap(
                                          () => showPopUp()
                                        )
                                      ),
                                      const SizedBox(width: 5.0),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: kGreyTextColor
                                                      .withOpacity(0.5)),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              color: Colors.transparent),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              lang.S.of(context).skip,
                                              style: kTextStyle.copyWith(
                                                  color: kGreyTextColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ).onTap(
                                          () => null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ).visible(false),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
