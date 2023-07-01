import 'package:cash_rocket/Model/offertoro_model.dart';
import 'package:cash_rocket/Provider/offertoro_provider.dart';
import 'package:cash_rocket/Screen/Offer%20Toro/offertoro_offer_details.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import '../../Model/user_profile_model.dart';
import '../../Provider/profile_provider.dart';
import '../Constant Data/constant.dart';
import '../Home Screen/no_internet_screen.dart';


class ComingSoonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          backgroundColor: Colors.deepPurple,
        title: Text(''),
      ),
      body: Container(
        color: Colors.deepPurple, // Choose your desired background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Stay tuned for exciting updates!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
class OffertoroOfferwall extends StatefulWidget {
  const OffertoroOfferwall({Key? key}) : super(key: key);

  @override
  State<OffertoroOfferwall> createState() => _OffertoroOfferwallState();
}

class _OffertoroOfferwallState extends State<OffertoroOfferwall> {
  List<String> imageList = [
    'images/rise.png',
    'images/my.png',
    'images/love.png',
    'images/annotate.png',
    'images/hey.png',
    'images/reach.png',
    'images/atlas.png',
  ];

  List<String> titleList = [
    'Rise of Kingdoms: Lost Crusade',
    'My Gym: Fitness Studio Manager',
    'Love Sick: Love Stories Games',
    'Annotate Images for Al',
    'Hey! More Cash!',
    'Reach Level 100 in The Game!',
    'Atlas VPN',
  ];
  List<String> subtitleList = [
    'Complete an action',
    'Complete an action',
    'Complete an action',
    'Complete an action',
    'Complete an action',
    'Complete an action',
    'Complete an action',
  ];

  List<String> points = [
    '+2921',
    '+2921',
    '+2921',
    '+2921',
    '+2921',
    '+2921',
    '+2921',
  ];

  List<String> categotyList = [
    'Top Offer!',
    'Free',
    'Hard',
  ];

  bool isBalanceShow = false;
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
    return Consumer(builder: (_, ref, watch) {
      AsyncValue<UserProfileModel> profile = ref.watch(personalProfileProvider);
      AsyncValue<OffertoroModel> offers = ref.watch(offertoroProvider);

      return profile.when(data: (info) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFDFD),
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
              lang.S.of(context).offerToro,
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
                      Text(isBalanceShow ? '${info.data?.user?.wallet?.balance ?? ''}' : lang.S.of(context).balance),
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
          body: offers.when(data: (offer) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        itemCount: offer.response?.offers?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, i) {
                          return Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: const Color(0xFFFFFFFF)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 65.0,
                                    width: 65.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            offer.response?.offers?[i].imageUrl ?? '',
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: context.width() / 1.5,
                                          child: Text(
                                            offer.response?.offers?[i].offerName ?? '',
                                            maxLines: 1,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: context.width() / 2.05,
                                              child: Text(
                                                offer.response?.offers?[i].callToAction ?? '',
                                                maxLines: 1,
                                                style: kTextStyle.copyWith(color: kGreyTextColor),
                                              ),
                                            ),
                                            Text(
                                              'BDT ${offer.response?.offers?[i].amount.toString() ?? ''}',
                                              style: kTextStyle.copyWith(color: kMainColor, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: context.width() / 1.5,
                                          child: HorizontalList(
                                              itemCount: offer.response?.offers?[i].verticals?.length ?? 1,
                                              itemBuilder: (_, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    gradient: const LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      colors: [
                                                        Color(0xFFFFABA5),
                                                        Color(0xFFFF7C92),
                                                      ],
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                                                    child: Text(
                                                      offer.response?.offers?[i].verticals?[index].verticalName.toString() ?? '',
                                                      style: kTextStyle.copyWith(color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).onTap(() => OffertoroOfferDetails(offertoroModel: offer.response!.offers![i], userId: info.data!.user!.id.toString()).launch(context));
                        })
                  ],
                ),
              ),
            );
          }, error: (e, stack) {
            return Text(
              e.toString(),
              style: kTextStyle.copyWith(color: kTitleColor),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
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
    });
  }
}
*/