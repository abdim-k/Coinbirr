import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screen/Constant Data/constant.dart';
import 'language_provider.dart';
import 'package:cash_rocket/generated/l10n.dart' as lang;

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  List<String> baseFlagsCode = [
    'US', // English
    'ET', // Amharic
    'ET-OR', // // Oromo
    'SA', // Arabic
    'ES', // Spanish
  ];

  List<String> countryList = [
    'English',
    'Amharic',
    'Oromo',
    'Arabic',
    'Spanish',
  ];

  String selectedCountry = 'English';

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
          lang.S.of(context).language,
          style: kTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
          child: ListView.builder(
              itemCount: countryList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: kBorderColorTextField, width: 0.3),
                        boxShadow: const [BoxShadow(color: kDarkWhite, offset: Offset(5, 5), spreadRadius: 2.0, blurRadius: 10.0)]),
                    child: ListTile(
                      horizontalTitleGap: 5,
                      onTap: () {
                        setState(
                              () {
                            selectedCountry = countryList[index];
                            if (selectedCountry == 'English') {
                              context.read<LanguageChangeProvider>().changeLocale("en");
                            } else if (selectedCountry == 'Amharic') {
                              context.read<LanguageChangeProvider>().changeLocale("am");
                            } else if (selectedCountry == 'Oromo') {
                              context.read<LanguageChangeProvider>().changeLocale("om");
                            } else if (selectedCountry == 'Arabic') {
                              context.read<LanguageChangeProvider>().changeLocale("ar");
                            }  else if (selectedCountry == 'Spanish') {
                              context.read<LanguageChangeProvider>().changeLocale("es");
                            }
                          },
                        );
                      },
                      leading: baseFlagsCode[index] == 'ET-OR'
                          ? Image.asset(
                        'images/oromo_flag.png',
                        height: 25,
                        width: 30,
                      )
                          : Flag.fromString(
                        baseFlagsCode[index],
                        height: 25,
                        width: 30,
                      ),

                      title: Text(countryList[index]),
                      trailing: selectedCountry == countryList[index]
                          ? const Icon(Icons.radio_button_checked, color: kMainColor)
                          : const Icon(
                        Icons.radio_button_off,
                        color: Color(0xff9F9F9F),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}


