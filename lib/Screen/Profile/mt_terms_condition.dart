import 'package:flutter/material.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;
import '../Constant Data/constant.dart';

class MtTermsAndCondition extends StatefulWidget {
  const MtTermsAndCondition({Key? key}) : super(key: key);

  @override
  State<MtTermsAndCondition> createState() => _MtTermsAndConditionState();
}

class _MtTermsAndConditionState extends State<MtTermsAndCondition> {
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
          lang.S.of(context).termsAndConditions,
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
              lang.S.of(context).termandConditionOfUse,
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
