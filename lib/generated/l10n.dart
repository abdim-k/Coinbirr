// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Cash Rocket`
  String get cashRocket {
    return Intl.message(
      'Cash Rocket',
      name: 'cashRocket',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message(
      'Remember Me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email Address`
  String get enterYourAddress {
    return Intl.message(
      'Enter Your Email Address',
      name: 'enterYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Haven’t any account?`
  String get havenotAnyAcconts {
    return Intl.message(
      'Haven’t any account?',
      name: 'havenotAnyAcconts',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Full name`
  String get enterFullName {
    return Intl.message(
      'Enter Your Full name',
      name: 'enterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email Address`
  String get enterYourEmail {
    return Intl.message(
      'Enter Your Email Address',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get mobile {
    return Intl.message(
      'Mobile',
      name: 'mobile',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Mobile`
  String get enterYourMobile {
    return Intl.message(
      'Enter Your Mobile',
      name: 'enterYourMobile',
      desc: '',
      args: [],
    );
  }

  /// `Enter invitation code`
  String get enterinvantationCode {
    return Intl.message(
      'Enter invitation code',
      name: 'enterinvantationCode',
      desc: '',
      args: [],
    );
  }

  /// `Invitation Code`
  String get invitationCode {
    return Intl.message(
      'Invitation Code',
      name: 'invitationCode',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your registered email address`
  String get enterYourRegistrationEmail {
    return Intl.message(
      'Enter your registered email address',
      name: 'enterYourRegistrationEmail',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continu {
    return Intl.message(
      'Continue',
      name: 'continu',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get otpVerify {
    return Intl.message(
      'Verify OTP',
      name: 'otpVerify',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-Enter password`
  String get reEnterPassword {
    return Intl.message(
      'Re-Enter password',
      name: 'reEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Cash Rocket`
  String get welcometoCashRocket {
    return Intl.message(
      'Welcome to Cash Rocket',
      name: 'welcometoCashRocket',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Skip for now`
  String get skipForNow {
    return Intl.message(
      'Skip for now',
      name: 'skipForNow',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Your Points`
  String get redemYOurPoint {
    return Intl.message(
      'Redeem Your Points',
      name: 'redemYOurPoint',
      desc: '',
      args: [],
    );
  }

  /// `Secure Your Money`
  String get secureYourMoney {
    return Intl.message(
      'Secure Your Money',
      name: 'secureYourMoney',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Refer`
  String get refer {
    return Intl.message(
      'Refer',
      name: 'refer',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message(
      'Withdraw',
      name: 'withdraw',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Term of Service`
  String get termsOfService {
    return Intl.message(
      'Term of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicty {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicty',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallary {
    return Intl.message(
      'Gallery',
      name: 'gallary',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saves {
    return Intl.message(
      'Save',
      name: 'saves',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Terms And Conditions of Use`
  String get termandConditionOfUse {
    return Intl.message(
      'Terms And Conditions of Use',
      name: 'termandConditionOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Date Updated” (7 Jun 2021)`
  String get dateUpdated {
    return Intl.message(
      'Date Updated” (7 Jun 2021)',
      name: 'dateUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privicyPolcy {
    return Intl.message(
      'Privacy Policy',
      name: 'privicyPolcy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy | Cash Rocket`
  String get privicyPolicyICashRocket {
    return Intl.message(
      'Privacy Policy | Cash Rocket',
      name: 'privicyPolicyICashRocket',
      desc: '',
      args: [],
    );
  }

  /// `Offer Status`
  String get offerStatus {
    return Intl.message(
      'Offer Status',
      name: 'offerStatus',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message(
      'In Progress',
      name: 'inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Your Fyber User ID is`
  String get yourFyberUserIDis {
    return Intl.message(
      'Your Fyber User ID is',
      name: 'yourFyberUserIDis',
      desc: '',
      args: [],
    );
  }

  /// `Rise of Kingdoms: Lost Crus...`
  String get riseofKingdomsLostCrus {
    return Intl.message(
      'Rise of Kingdoms: Lost Crus...',
      name: 'riseofKingdomsLostCrus',
      desc: '',
      args: [],
    );
  }

  /// `Complete an action`
  String get completeanaction {
    return Intl.message(
      'Complete an action',
      name: 'completeanaction',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get instructions {
    return Intl.message(
      'Instructions',
      name: 'instructions',
      desc: '',
      args: [],
    );
  }

  /// `Total Rewards`
  String get totalRewards {
    return Intl.message(
      'Total Rewards',
      name: 'totalRewards',
      desc: '',
      args: [],
    );
  }

  /// `Days to complete`
  String get daysToComplete {
    return Intl.message(
      'Days to complete',
      name: 'daysToComplete',
      desc: '',
      args: [],
    );
  }

  /// `Earn 2921 points`
  String get earnpoints {
    return Intl.message(
      'Earn 2921 points',
      name: 'earnpoints',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations`
  String get congratulations {
    return Intl.message(
      'Congratulations',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Daily Reward!`
  String get dailyReward {
    return Intl.message(
      'Daily Reward!',
      name: 'dailyReward',
      desc: '',
      args: [],
    );
  }

  /// `Collect Daily Reward Now!`
  String get collectDailyRewardNow {
    return Intl.message(
      'Collect Daily Reward Now!',
      name: 'collectDailyRewardNow',
      desc: '',
      args: [],
    );
  }

  /// `All Features`
  String get allFeatures {
    return Intl.message(
      'All Features',
      name: 'allFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  /// `Videos`
  String get videos {
    return Intl.message(
      'Videos',
      name: 'videos',
      desc: '',
      args: [],
    );
  }

  /// `Wheel`
  String get wheel {
    return Intl.message(
      'Wheel',
      name: 'wheel',
      desc: '',
      args: [],
    );
  }

  /// `Redeem`
  String get redeem {
    return Intl.message(
      'Redeem',
      name: 'redeem',
      desc: '',
      args: [],
    );
  }

  /// `Quiz`
  String get quiz {
    return Intl.message(
      'Quiz',
      name: 'quiz',
      desc: '',
      args: [],
    );
  }

  /// `Tutorial`
  String get tutorial {
    return Intl.message(
      'Tutorial',
      name: 'tutorial',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection Found`
  String get noInternetCollection {
    return Intl.message(
      'No Internet Connection Found',
      name: 'noInternetCollection',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Enter Coin Amount`
  String get enterCoinAmount {
    return Intl.message(
      'Enter Coin Amount',
      name: 'enterCoinAmount',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Account`
  String get withdrawAccount {
    return Intl.message(
      'Withdraw Account',
      name: 'withdrawAccount',
      desc: '',
      args: [],
    );
  }

  /// `Offertoro`
  String get offerToro {
    return Intl.message(
      'Offertoro',
      name: 'offerToro',
      desc: '',
      args: [],
    );
  }

  /// `Earn BDT`
  String get earbdt {
    return Intl.message(
      'Earn BDT',
      name: 'earbdt',
      desc: '',
      args: [],
    );
  }

  /// `Points received`
  String get pointRecived {
    return Intl.message(
      'Points received',
      name: 'pointRecived',
      desc: '',
      args: [],
    );
  }

  /// `Spin the Wheel`
  String get spinTheWheel {
    return Intl.message(
      'Spin the Wheel',
      name: 'spinTheWheel',
      desc: '',
      args: [],
    );
  }

  /// `Press the SPIN Wheel`
  String get pressTheSpinWheel {
    return Intl.message(
      'Press the SPIN Wheel',
      name: 'pressTheSpinWheel',
      desc: '',
      args: [],
    );
  }

  /// `Watch Video (Earn 50 Coins)`
  String get watchVideoAndEarn {
    return Intl.message(
      'Watch Video (Earn 50 Coins)',
      name: 'watchVideoAndEarn',
      desc: '',
      args: [],
    );
  }

  /// `Invite Your Friends`
  String get inviteYourFriends {
    return Intl.message(
      'Invite Your Friends',
      name: 'inviteYourFriends',
      desc: '',
      args: [],
    );
  }

  /// `Invite your friends to use Cash Rocket and you will receive 100 points for each one`
  String get inviteYourFriendtoUseCashRocket {
    return Intl.message(
      'Invite your friends to use Cash Rocket and you will receive 100 points for each one',
      name: 'inviteYourFriendtoUseCashRocket',
      desc: '',
      args: [],
    );
  }

  /// `Invite Now`
  String get inviteNow {
    return Intl.message(
      'Invite Now',
      name: 'inviteNow',
      desc: '',
      args: [],
    );
  }

  /// `Are you agree?`
  String get areYouAgree {
    return Intl.message(
      'Are you agree?',
      name: 'areYouAgree',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get No {
    return Intl.message(
      'No',
      name: 'No',
      desc: '',
      args: [],
    );
  }

  /// `Winner!`
  String get winner {
    return Intl.message(
      'Winner!',
      name: 'winner',
      desc: '',
      args: [],
    );
  }

  /// `No Quiz Found`
  String get noQuizFound {
    return Intl.message(
      'No Quiz Found',
      name: 'noQuizFound',
      desc: '',
      args: [],
    );
  }

  /// `Amet minim mollit non deserunt ullamc est sit aliqua'`
  String get amentMinim {
    return Intl.message(
      'Amet minim mollit non deserunt ullamc est sit aliqua\'',
      name: 'amentMinim',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Sorry`
  String get sorry {
    return Intl.message(
      'Sorry',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// `You Lose`
  String get youLose {
    return Intl.message(
      'You Lose',
      name: 'youLose',
      desc: '',
      args: [],
    );
  }

  /// `Play again`
  String get playAgain {
    return Intl.message(
      'Play again',
      name: 'playAgain',
      desc: '',
      args: [],
    );
  }

  /// `Share Score`
  String get shareSqure {
    return Intl.message(
      'Share Score',
      name: 'shareSqure',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us`
  String get rateUs {
    return Intl.message(
      'Rate Us',
      name: 'rateUs',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `VICTORY`
  String get victory {
    return Intl.message(
      'VICTORY',
      name: 'victory',
      desc: '',
      args: [],
    );
  }

  /// `Earn Points`
  String get earnPoint {
    return Intl.message(
      'Earn Points',
      name: 'earnPoint',
      desc: '',
      args: [],
    );
  }

  /// `Top Offer!`
  String get topOffer {
    return Intl.message(
      'Top Offer!',
      name: 'topOffer',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Hard`
  String get hard {
    return Intl.message(
      'Hard',
      name: 'hard',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Reward`
  String get reward {
    return Intl.message(
      'Reward',
      name: 'reward',
      desc: '',
      args: [],
    );
  }

  /// `Wannads Offerwall`
  String get wannadsOfferwall {
    return Intl.message(
      'Wannads Offerwall',
      name: 'wannadsOfferwall',
      desc: '',
      args: [],
    );
  }

  /// `Earn BDT`
  String get earnbdt {
    return Intl.message(
      'Earn BDT',
      name: 'earnbdt',
      desc: '',
      args: [],
    );
  }

  /// `Personaly`
  String get personaly {
    return Intl.message(
      'Personaly',
      name: 'personaly',
      desc: '',
      args: [],
    );
  }

  /// `earn`
  String get earn {
    return Intl.message(
      'earn',
      name: 'earn',
      desc: '',
      args: [],
    );
  }

  /// `Og Ads`
  String get ogAds {
    return Intl.message(
      'Og Ads',
      name: 'ogAds',
      desc: '',
      args: [],
    );
  }

  /// `Kiwi Wall`
  String get kiwiwall {
    return Intl.message(
      'Kiwi Wall',
      name: 'kiwiwall',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address below to recive your`
  String get pleaseEnterYourAddressbelow {
    return Intl.message(
      'Please enter your email address below to recive your',
      name: 'pleaseEnterYourAddressbelow',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the code below to reset your`
  String get pleaseResetYOurCode {
    return Intl.message(
      'Please enter the code below to reset your',
      name: 'pleaseResetYOurCode',
      desc: '',
      args: [],
    );
  }

  /// `1.  Play Rise of Kingdoms`
  String get playRiseofKingdoms {
    return Intl.message(
      '1.  Play Rise of Kingdoms',
      name: 'playRiseofKingdoms',
      desc: '',
      args: [],
    );
  }

  /// `2. Upgrade your city ot level 17`
  String get upgradeyourcityotlevel17 {
    return Intl.message(
      '2. Upgrade your city ot level 17',
      name: 'upgradeyourcityotlevel17',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'hereComesYourReward!' key

  /// `4.  Please complete the task within 22 days`
  String get pleaseCompleteTheTaskWithin22days {
    return Intl.message(
      '4.  Please complete the task within 22 days',
      name: 'pleaseCompleteTheTaskWithin22days',
      desc: '',
      args: [],
    );
  }

  /// `5.  User can only obtain reward from ONE Rise of kingdoms offer `
  String get userCanaonly {
    return Intl.message(
      '5.  User can only obtain reward from ONE Rise of kingdoms offer ',
      name: 'userCanaonly',
      desc: '',
      args: [],
    );
  }

  /// `Let’s Get Startes`
  String get letsGetStarted {
    return Intl.message(
      'Let’s Get Startes',
      name: 'letsGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get continueWithFacebok {
    return Intl.message(
      'Continue with Facebook',
      name: 'continueWithFacebok',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Email`
  String get signUpwitEmail {
    return Intl.message(
      'Sign up with Email',
      name: 'signUpwitEmail',
      desc: '',
      args: [],
    );
  }

  /// `A`
  String get a {
    return Intl.message(
      'A',
      name: 'a',
      desc: '',
      args: [],
    );
  }

  /// `B`
  String get b {
    return Intl.message(
      'B',
      name: 'b',
      desc: '',
      args: [],
    );
  }

  /// `C`
  String get c {
    return Intl.message(
      'C',
      name: 'c',
      desc: '',
      args: [],
    );
  }

  /// `D`
  String get d {
    return Intl.message(
      'D',
      name: 'd',
      desc: '',
      args: [],
    );
  }

  /// `Ullamcorper eros senectus urna sit elementum ali quet. Nibh mauris tristique elit pellentesque sa pien malesuada eleifend iaculis malesuada. Mau ris, ut id hendrerit habitant gravida urna congue arcu sit. At quisque leo semper urna gravida`
  String get ullamcorperEros {
    return Intl.message(
      'Ullamcorper eros senectus urna sit elementum ali quet. Nibh mauris tristique elit pellentesque sa pien malesuada eleifend iaculis malesuada. Mau ris, ut id hendrerit habitant gravida urna congue arcu sit. At quisque leo semper urna gravida',
      name: 'ullamcorperEros',
      desc: '',
      args: [],
    );
  }

  /// `iaculis nibh aliquam. Morbi tempor facilisi ultricies magna vitae sit. Velit augue sagittis, tempor, amet arcu nullam quam. Sit feugiat amet, pellentesque morbi mattis id blandit arcu morbi. Morbi cursus ac tortor amet. Iaculis nunc bibendum in vitae turpis mattis nisl viverra. Turpis habitant purus, venenatis vitae ut urna, rhoncus nunc. Aliquam turpis pellentesque arcu malesuada ut et lorem. Donec tincidunt tristique ultricies sed faucibus. Morbi et eu mi, nec, suscipit. Duis pellentesque facilisi pharetra enim neque sagittis.`
  String get iaculisNibh {
    return Intl.message(
      'iaculis nibh aliquam. Morbi tempor facilisi ultricies magna vitae sit. Velit augue sagittis, tempor, amet arcu nullam quam. Sit feugiat amet, pellentesque morbi mattis id blandit arcu morbi. Morbi cursus ac tortor amet. Iaculis nunc bibendum in vitae turpis mattis nisl viverra. Turpis habitant purus, venenatis vitae ut urna, rhoncus nunc. Aliquam turpis pellentesque arcu malesuada ut et lorem. Donec tincidunt tristique ultricies sed faucibus. Morbi et eu mi, nec, suscipit. Duis pellentesque facilisi pharetra enim neque sagittis.',
      name: 'iaculisNibh',
      desc: '',
      args: [],
    );
  }

  /// `Luctus mauris pharetra sit elit integer consec tetur etiam quis auctor.`
  String get lactusMautis {
    return Intl.message(
      'Luctus mauris pharetra sit elit integer consec tetur etiam quis auctor.',
      name: 'lactusMautis',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetur adip is ci ng elit. Neque nulla sed mauris feugiat eget. Augu e id neque nisl nibh ut facilisis massa,`
  String get loremipsum {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetur adip is ci ng elit. Neque nulla sed mauris feugiat eget. Augu e id neque nisl nibh ut facilisis massa,',
      name: 'loremipsum',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'af'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'az'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'bs'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'da'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'fi'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ha'),
      Locale.fromSubtags(languageCode: 'he'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'hr'),
      Locale.fromSubtags(languageCode: 'hu'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'kk'),
      Locale.fromSubtags(languageCode: 'km'),
      Locale.fromSubtags(languageCode: 'kn'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'ku'),
      Locale.fromSubtags(languageCode: 'lo'),
      Locale.fromSubtags(languageCode: 'mr'),
      Locale.fromSubtags(languageCode: 'ms'),
      Locale.fromSubtags(languageCode: 'my'),
      Locale.fromSubtags(languageCode: 'ne'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'si'),
      Locale.fromSubtags(languageCode: 'sk'),
      Locale.fromSubtags(languageCode: 'sq'),
      Locale.fromSubtags(languageCode: 'sr'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'sw'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'ti'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'ur'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
