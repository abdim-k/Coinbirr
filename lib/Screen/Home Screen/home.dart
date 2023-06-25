import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:cash_rocket/Screen/History/mt_history.dart';
import 'package:cash_rocket/Screen/Home%20Screen/Features%20Screen/mt_quiz.dart';
import 'package:cash_rocket/Screen/Profile/mt_profile.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../Constant Data/constant.dart';
import 'mt_home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MtQuiz(),
    History(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_currentPage),
      bottomNavigationBar: BottomBar(
        backgroundColor: Colors.white,
        items: [
          /// Home
          BottomBarItem(
            icon: const Icon(MdiIcons.home),
            title: Text(
              "Home",
              style: kTextStyle.copyWith(color: kMainColor),
            ),
            activeColor: kMainColor,
            inactiveColor: kMainColor.withOpacity(0.5),
          ),

          /// Orders
          BottomBarItem(
            backgroundColorOpacity: 0.1,
            icon: const Icon(BootstrapIcons.chat_dots),
            title: Text(
              "Quizzes",
              style: kTextStyle.copyWith(color: kMainColor),
            ),
            activeColor: kMainColor,
            inactiveColor: kMainColor.withOpacity(0.5),
          ),

          /// History
          BottomBarItem(
            icon: const Icon(MdiIcons.textBox),
            title: Text(
              "History",
              style: kTextStyle.copyWith(color: kMainColor),
            ),
            activeColor: kMainColor,
            inactiveColor: kMainColor.withOpacity(0.5),
          ),

          /// Profile
          BottomBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text("Profile"),
            activeColor: kMainColor,
            inactiveColor: kMainColor.withOpacity(0.5),
          ),
        ],
        onTap: (int index) {
          setState(() => _currentPage = index);
        },
        selectedIndex: _currentPage,
      ),
    );
  }
}
