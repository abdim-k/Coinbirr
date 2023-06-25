import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cash_rocket/Model/user_profile_model.dart';
import 'package:cash_rocket/Provider/profile_provider.dart';
import 'package:cash_rocket/Screen/Authentication/log_in.dart';
import 'package:cash_rocket/Screen/Profile/mt_edit_profile.dart';
import 'package:cash_rocket/Screen/Profile/mt_offer_status.dart';
import 'package:cash_rocket/Screen/Profile/mt_privacy_policy.dart';
import 'package:cash_rocket/Screen/Profile/mt_terms_condition.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Provider/database_provider.dart';
import '../../Repositories/authentication_repo.dart';
import '../Constant Data/config.dart';
import '../Constant Data/constant.dart';
import '../../language/languase.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserProfileModel user = UserProfileModel();
  List<String> count = [
    '5000',
    '7+',
    '15+',
  ];

  List<String> title = [
    'Blance',
    'Refer',
    'Invited',
  ];

  void signOut() async {
    try {
      EasyLoading.show(status: 'Signing Out...');
      var response = await AuthRepo().logOut();
      if (response && mounted) {
        DataBase().saveString('', 'token');
        const LogIn().launch(context, isNewTask: true);
        EasyLoading.showSuccess('Sign Out Successful');
      } else {
        EasyLoading.showError('Please Try Again');
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (_, ref, watch) {
        AsyncValue<UserProfileModel> profile = ref.watch(personalProfileProvider);
        return profile.when(data: (info) {
          if (info.data?.user?.status == 0) {
            DataBase().deleteToken();
            EasyLoading.showError('You Are Disable!');
            const LogIn().launch(context, isNewTask: true);
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: context.width(),
                  decoration: const BoxDecoration(
                    color: kMainColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40.0),
                      Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 40,
                              backgroundImage: NetworkImage(info.data?.user?.image == Config.siteUrl
                                  ? 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png'
                                  : info.data?.user?.image ?? 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png'),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            info.data?.user?.name ?? '',
                            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            info.data?.user?.email ?? '',
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 5.0),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: context.width(),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Color(0xFFFFABA5),
                        Color(0xFFFF7C92),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.3), border: Border.all(color: Colors.white)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      info.data?.user?.wallet?.balance.toString() ?? '',
                                      style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              lang.S.of(context).balance,
                              style: kTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.3), border: Border.all(color: Colors.white)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      info.data?.referUserCount.toString() ?? '',
                                      style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              lang.S.of(context).refer,
                              style: kTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.3), border: Border.all(color: Colors.white)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      info.data?.withdrawRequestCount.toString() ?? '',
                                      style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              lang.S.of(context).withdraw,
                              style: kTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: kGreyTextColor.withOpacity(0.1), width: 1.0)),
                      child: ListTile(
                        onTap: (() => EditProfile(user: info).launch(context)),
                        horizontalTitleGap: 2,
                        leading: const Icon(
                          Icons.person,
                          color: kMainColor,
                        ),
                        title: Text(lang.S.of(context).editProfile),
                        trailing: const Icon(FeatherIcons.chevronRight),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: kGreyTextColor.withOpacity(0.1), width: 1.0)),
                      child: ListTile(
                        onTap: (() => const OfferStatus().launch(context)),
                        horizontalTitleGap: 2,
                        leading: const Icon(
                          FontAwesomeIcons.fileLines,
                          color: kMainColor,
                        ),
                        title: Text(lang.S.of(context).offerStatus),
                        trailing: const Icon(FeatherIcons.chevronRight),
                      )),
                ).visible(false),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: kGreyTextColor.withOpacity(0.1), width: 1.0)),
                      child: ListTile(
                        onTap: (() => const MtTermsAndCondition().launch(context)),
                        horizontalTitleGap: 2,
                        leading: const Icon(
                          BootstrapIcons.shield_check,
                          color: kMainColor,
                        ),
                        title: Text(lang.S.of(context).termsOfService),
                        trailing: const Icon(FeatherIcons.chevronRight),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: kGreyTextColor.withOpacity(0.1), width: 1.0)),
                      child: ListTile(
                        onTap: (() => const Language().launch(context)),
                        horizontalTitleGap: 2,
                        leading: const Icon(
                          CommunityMaterialIcons.translate,
                          color: kMainColor,
                        ),
                        title: Text(lang.S.of(context).language),
                        trailing: const Icon(FeatherIcons.chevronRight),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: kGreyTextColor.withOpacity(0.1), width: 1.0)),
                      child: ListTile(
                        onTap: (() => const MtPrivacyPolicy().launch(context)),
                        horizontalTitleGap: 2,
                        leading: const Icon(
                          FeatherIcons.info,
                          color: kMainColor,
                        ),
                        title: Text(lang.S.of(context).privacyPolicty),
                        trailing: const Icon(FeatherIcons.chevronRight),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: kGreyTextColor.withOpacity(0.1), width: 1.0)),
                      child: ListTile(
                        onTap: (() => signOut()),
                        horizontalTitleGap: 2,
                        leading: const Icon(
                          Icons.logout,
                          color: kMainColor,
                        ),
                        title: Text(lang.S.of(context).logOut),
                        trailing: const Icon(FeatherIcons.chevronRight),
                      )),
                ),
              ],
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
    );
  }
}
