import 'package:cash_rocket/Screen/Constant%20Data/button_global.dart';
import 'package:cash_rocket/Screen/Home%20Screen/home.dart';
import 'package:cash_rocket/Screen/Profile/mt_offer_status.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import '../Constant Data/constant.dart';

class MtOfferStatusDetails extends StatefulWidget {
  const MtOfferStatusDetails({Key? key}) : super(key: key);

  @override
  State<MtOfferStatusDetails> createState() => _MtOfferStatusDetailsState();
}

class _MtOfferStatusDetailsState extends State<MtOfferStatusDetails> {
  List<String> categoryList = [
    'Top Offer!',
    'Free',
    'Hard',
  ];
  List<Color> colorList = [
    const Color(0xFFFFABA5),
    const Color(0xFFFFA6A5),
    const Color(0xFFFFBF53),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
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
          title: ListTile(
            minLeadingWidth: 0,
            leading: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: AssetImage('images/rok.png'),
                  )),
            ),
            title: Text(
              lang.S.of(context).riseofKingdomsLostCrus,
              style: kTextStyle.copyWith(color: Colors.white),
            ),
            subtitle: Text(
              lang.S.of(context).completeanaction,
              style: kTextStyle.copyWith(color: Colors.white),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: const Icon(Icons.close, color: Colors.white).onTap(
                () => const OfferStatus().launch(context),
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: const DecorationImage(
                    image: AssetImage('images/rokbanner.png'),
                  ),
                ),
              ),
              HorizontalList(
                spacing: 10,
                itemCount: categoryList.length,
                itemBuilder: (_, i) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: colorList[i],
                    ),
                    child: Text(
                      categoryList[i],
                    ),
                  );
                },
              ),
              Text(
                lang.S.of(context).instructions,
                style: kTextStyle.copyWith(
                    color: kTitleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              const SizedBox(height: 5.0),
              Text(
                '1.  Play Rise of Kingdoms',
                style: kTextStyle.copyWith(color: kGreyTextColor),
                maxLines: 5,
              ),
              const SizedBox(height: 5.0),
              Text(
                '2. Upgrade your city ot level 17',
                style: kTextStyle.copyWith(color: kGreyTextColor),
                maxLines: 5,
              ),
              const SizedBox(height: 5.0),
              Text(
                '3.  Here comes your reward!',
                style: kTextStyle.copyWith(color: kGreyTextColor),
                maxLines: 5,
              ),
              const SizedBox(height: 5.0),
              Text(
                '4.  Please complete the task within 22 days',
                style: kTextStyle.copyWith(color: kGreyTextColor),
                maxLines: 5,
              ),
              const SizedBox(height: 5.0),
              Text(
                '5.  User can only obtain reward from ONE Rise of kingdoms offer ',
                style: kTextStyle.copyWith(color: kGreyTextColor),
                maxLines: 5,
              ),
              const SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kGreyTextColor.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kMainColor,
                              ),
                              child: const Icon(
                                FeatherIcons.dollarSign,
                                color: Colors.white,
                                size: 16.0,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              '2921',
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              lang.S.of(context).totalRewards,
                              style: kTextStyle.copyWith(color: kGreyTextColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 80.0,
                      width: 1.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.0),
                        color: kGreyTextColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              FeatherIcons.calendar,
                              color: Color(0xFF8555EA),
                              size: 24.0,
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              '22',
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              lang.S.of(context).daysToComplete,
                              style: kTextStyle.copyWith(color: kGreyTextColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              ButtonGlobal(buttontext: lang.S.of(context).earnpoints, buttonDecoration: kButtonDecoration, onPressed:(){
                setState(() {
                  const Home().launch(context);
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}
