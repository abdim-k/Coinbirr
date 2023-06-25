import 'package:flutter/material.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
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
          lang.S.of(context).privicyPolcy,
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
              lang.S.of(context).privicyPolicyICashRocket,
              style: kTextStyle.copyWith(
                  color: kTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              lang.S.of(context).dateUpdated,
              style: kTextStyle.copyWith(color: kGreyTextColor),
            ),
            const SizedBox(height: 10.0),
            Text(
              lang.S.of(context).loremipsum,
              style: kTextStyle.copyWith(color: kGreyTextColor),
            ),
            const SizedBox(height: 10.0),
            Text(
              lang.S.of(context).ullamcorperEros,
              style: kTextStyle.copyWith(color: kGreyTextColor),
            ),
            const SizedBox(height: 10.0),
            Text(
              lang.S.of(context).iaculisNibh,
              style: kTextStyle.copyWith(color: kGreyTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
