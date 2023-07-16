import 'package:cash_rocket/Provider/profile_provider.dart';
import 'package:cash_rocket/Repositories/rewards_repo.dart';
import 'package:cash_rocket/Screen/Home%20Screen/Features%20Screen/Quiz/mt_football.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Model/quiz_model.dart';
import '../../../Model/user_profile_model.dart';
import '../../../Provider/database_provider.dart';
import '../../Authentication/log_in.dart';
import '../../Constant Data/constant.dart';
import '../no_internet_screen.dart';

class MtQuiz extends StatefulWidget {
  const MtQuiz({Key? key}) : super(key: key);

  @override
  State<MtQuiz> createState() => _MtQuizState();
}

class _MtQuizState extends State<MtQuiz> {
  //bool isInterstitialLoaded=false;


  @override
  void initState() {
    checkInternet();
    super.initState();
    /* FacebookAudienceNetwork.init(
        testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
        iOSAdvertiserTrackingEnabled: true
    );
    //default false
     */
  }

/*
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadInterstitial();
  }

  void loadInterstitial() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#793824048967170_813764000306508", // add # your id after test id
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED)
          FacebookInterstitialAd.showInterstitialAd(delay: 5000);
      },
    );
  }

 */

  void showPopUp(String amount, Quizzes quizzes) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  'If you play this quiz then $amount points will be deducted!',
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
                            bool status = await RewardRepo()
                                .removePoint(amount, 'Paid Quiz Play');
                            if (status && mounted) {
                              EasyLoading.showSuccess('Successful');
                              MtFootball(
                                quizzes: quizzes,
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
                              style: kTextStyle.copyWith(color: kGreyTextColor),
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
        );
      },
    ).then((value) {
      // This code block will execute after the dialog is closed
     // FacebookInterstitialAd.showInterstitialAd();
    });
  }

  void showRewardsPopUp() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: const DecorationImage(
                            image: AssetImage('images/banner3.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
                            Text(
                              lang.S.of(context).winner,
                              style: kTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'You have already won this quiz. Try playing other quiz',
                              style: kTextStyle.copyWith(
                                  color: Colors.white, fontSize: 18.0),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [
                                      Color(0xFFFFBF53),
                                      Color(0xFFFF8244),
                                    ]),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: Text(
                                  lang.S.of(context).ok,
                                  style: kTextStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ).onTap(() => {
                                  finish(context),
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
    ).then((value) {
      // This code block will execute after the dialog is closed
     // FacebookInterstitialAd.showInterstitialAd();
    });
  }

  List<Color> colorList = [
    const Color(0xFFFF7288),
    const Color(0xFF8555EA),
    const Color(0xFF2F81E8),
    const Color(0xFFFF8244),
  ];

  bool isBalanceShow = false;

  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result && mounted) {
      NoInternetScreen(screenName: widget).launch(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, watch) {
      AsyncValue<UserProfileModel> userInfo =
          ref.watch(personalProfileProvider);
      AsyncValue<QuizModel> allQuiz = ref.watch(quizProvider);
      return userInfo.when(data: (info) {
        if (info.data?.user?.status == 0) {
          DataBase().deleteToken();
          EasyLoading.showError('You Are Disable!');

          const LogIn().launch(context, isNewTask: true);
        }
        return Scaffold(
          appBar: AppBar(
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
              lang.S.of(context).quizz,
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
                    ),
                  ),
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
                          ? info.data!.user!.wallet!.balance.toString()
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
          body: allQuiz.when(data: (quiz) {
            return quiz.data!.categoryQuiz!.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async => ref.refresh(quizProvider),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 10.0),
                            ListView.builder(
                                itemCount: quiz.data?.categoryQuiz?.length ?? 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: ExpansionTile(
                                      initiallyExpanded: i == 0 ? true : false,
                                      iconColor: Colors.white,
                                      collapsedBackgroundColor:
                                          colorList[i % 4],
                                      backgroundColor: colorList[i % 4],
                                      title: Text(
                                        quiz.data!.categoryQuiz![i].name ?? '',
                                        style: kTextStyle.copyWith(
                                            color: Colors.white),
                                      ),
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                          quiz.data!.categoryQuiz![i].image ??
                                              '',
                                        ),
                                      ),
                                      children: [
                                        ListView.builder(
                                            itemCount: quiz
                                                    .data
                                                    ?.categoryQuiz?[i]
                                                    .quizzes
                                                    ?.length ??
                                                0,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (_, index) {
                                              return Container(
                                                color: Colors.white,
                                                child: ListTile(
                                                  onTap: () async {
                                                    try {
                                                      EasyLoading.show(
                                                          status: 'Loading...');
                                                      var status =
                                                          await RewardRepo()
                                                              .checkQuiz(quiz
                                                                  .data!
                                                                  .categoryQuiz![
                                                                      i]
                                                                  .quizzes![
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                      if (status.data!.userQuiz!
                                                                  .winStatus ==
                                                              '0' &&
                                                          status.data!.userQuiz!
                                                                  .resultStatus ==
                                                              '3') {
                                                        EasyLoading.showError(
                                                            'You are retaking the quiz...');
                                                        showPopUp(
                                                            quiz
                                                                .data!
                                                                .categoryQuiz![
                                                                    i]
                                                                .quizzes![index]
                                                                .freeOrPaid
                                                                .toString(),
                                                            quiz
                                                                .data!
                                                                .categoryQuiz![
                                                                    i]
                                                                .quizzes![index]);
                                                      } else if (status
                                                                  .data!
                                                                  .userQuiz!
                                                                  .winStatus ==
                                                              '1' &&
                                                          status.data!.userQuiz!
                                                                  .resultStatus ==
                                                              '1') {
                                                        EasyLoading.showError(
                                                            'Already Played...');
                                                        showRewardsPopUp();
                                                      }
                                                    } catch (e) {
                                                      EasyLoading.showSuccess(
                                                          'Successful');
                                                      if (quiz
                                                              .data!
                                                              .categoryQuiz![i]
                                                              .quizzes![index]
                                                              .paidStatus ==
                                                          0) {
                                                        MtFootball(
                                                          quizzes: quiz
                                                              .data!
                                                              .categoryQuiz![i]
                                                              .quizzes![index],
                                                        ).launch(context);
                                                      } else {
                                                        showPopUp(
                                                            quiz
                                                                .data!
                                                                .categoryQuiz![
                                                                    i]
                                                                .quizzes![index]
                                                                .freeOrPaid
                                                                .toString(),
                                                            quiz
                                                                .data!
                                                                .categoryQuiz![
                                                                    i]
                                                                .quizzes![index]);
                                                      }
                                                    }
                                                  },
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  leading: CircleAvatar(
                                                    backgroundColor: kMainColor
                                                        .withOpacity(0.1),
                                                    radius: 20,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      quiz
                                                              .data!
                                                              .categoryQuiz![i]
                                                              .quizzes![index]
                                                              .image ??
                                                          '',
                                                    ),
                                                  ),
                                                  title: Text(
                                                    quiz
                                                            .data!
                                                            .categoryQuiz![i]
                                                            .quizzes![index]
                                                            .name ??
                                                        '',
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle: Text(
                                                    'Entry Fee: ${quiz.data!.categoryQuiz![i].quizzes![index].paidStatus == 0 ? 'Free' : quiz.data!.categoryQuiz![i].quizzes![index].freeOrPaid.toString()} || Reward Point: ${quiz.data!.categoryQuiz![i].quizzes![index].rewardPoint}',
                                                    style: kTextStyle.copyWith(
                                                        color: kGreyTextColor),
                                                  ),
                                                  trailing: const Icon(
                                                      FeatherIcons.chevronRight,
                                                      color: kGreyTextColor),
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(lang.S.of(context).noQuizFound),
                  );
          }, error: (e, stack) {
            return Center(
              child: Text(e.toString()),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        );
      }, error: (e, stack) {
        print(stack);
        return Center(
          child: Text(stack.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
    });
  }
}
