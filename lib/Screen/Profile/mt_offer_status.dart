import 'package:cash_rocket/Screen/Profile/mt_offer_status_details.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import '../Constant Data/constant.dart';

class OfferStatus extends StatefulWidget {
  const OfferStatus({Key? key}) : super(key: key);

  @override
  State<OfferStatus> createState() => _OfferStatusState();
}

class _OfferStatusState extends State<OfferStatus> {
  List<String> imageList = [
    'images/rise.png',
    'images/gym.png',
    'images/lovesick.png',
  ];

  List<String> titleList = [
    'Rise of Kingdoms: Lost Crusade',
    'My Gym: Fitness Studio Manager',
    'Love Sick: Love Stories Games',
  ];
  List<String> stageList = ['Hard', 'Free', 'Medium'];

  List<String> subtitleList = [
    'Complete an action',
    'Complete an action',
    'Complete an action'
  ];

  List<String> point = [
    '+2921',
    '+2921',
    '+2921',
  ];

  List<Color> colorList = [
    const Color(0xFFFFBF53),
    const Color(0xFFFFA6A5),
    const Color(0xFF2F81E8),
  ];

  List<Widget> screenList=[
    const MtOfferStatusDetails(),
    const MtOfferStatusDetails(),
    const MtOfferStatusDetails(),
  ];

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
          lang.S.of(context).offerStatus,
          style: kTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Text(
              lang.S.of(context).inProgress,
              style: kTextStyle.copyWith(
                  color: kMainColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            ListView.builder(
                itemCount: imageList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, i) {
                  return Card(
                    elevation: 1.0,
                    shadowColor: Colors.white,
                    child: ListTile(
                      onTap: (()=>screenList[i].launch(context)),
                      leading: Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(
                                imageList[i],
                              ),
                            )),
                      ),
                      title: Text(
                        titleList[i],
                        style: kTextStyle.copyWith(color: kTitleColor),
                      ),
                      isThreeLine: true,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                subtitleList[i],
                                style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                              const Spacer(),
                              Text(
                                point[i],
                                style: kTextStyle.copyWith(color: kMainColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: colorList[i],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 2.0,
                                  bottom: 2.0),
                              child: Text(
                                stageList[i],
                                style: kTextStyle.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 20.0),
            Center(
              child: RichText(
                  text: TextSpan(
                      text: lang.S.of(context).yourFyberUserIDis,
                      style: kTextStyle.copyWith(color: kGreyTextColor),
                      children: [
                    TextSpan(
                      text: '2361246',
                      style: kTextStyle.copyWith(
                          color: kTitleColor, fontWeight: FontWeight.bold),
                    )
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
