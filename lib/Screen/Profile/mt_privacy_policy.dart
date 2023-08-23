import 'package:flutter/material.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constant Data/constant.dart';
class MtPrivacyPolicy extends StatefulWidget {
  const MtPrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<MtPrivacyPolicy> createState() => _MtPrivacyPolicyState();
}

class _MtPrivacyPolicyState extends State<MtPrivacyPolicy> {
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
          lang.S.of(context).privicyPolcyy,
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
              lang.S.of(context).privicyPolicyICashRockett,
              style: kTextStyle.copyWith(
                  color: kTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Coinbirr v 2.0.0',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              lang.S.of(context).dateUpdatedd,
              style: kTextStyle.copyWith(color: kGreyTextColor),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: const CircleAvatar(
                backgroundImage: AssetImage('images/profileimg.png'),
                radius: 50.0,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: const Text(
                'Abdi Musa',

                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: const Text(
                'Developer and creotor of Coinbirr app',

                style: TextStyle(
                  fontSize: 15.0,

                ),
              ),

            ),
            SizedBox(height: 10,),

            const SizedBox(height: 10.0),
            Text(
              lang.S.of(context).loremipsumm,
              style: kTextStyle.copyWith(color: kGreyTextColor),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.telegram),
                    onPressed: () => launch('https://t.me/+CvEp1jdU52tkNTNk'),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram),
                    onPressed: () =>
                        launch('https://instagram.com/abdim_k?igshid=MjEwN2IyYWYwYw=='),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook),
                    onPressed: () => launch(
                        'https://www.facebook.com/profile.php?id=100089875688543&mibextid=ZbWKwL'),
                  ),


                ],
              ),
            ),
            const SizedBox(height: 10.0),


          ],
        ),
      ),
    );
  }
}
