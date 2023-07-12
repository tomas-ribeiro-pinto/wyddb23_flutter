import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:wyddb23_flutter/Components/carousel.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/Components/wyd_resources.dart';
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../Components/my_text.dart';
import '../../Components/rounded_card.dart';

class WelcomeActivity extends StatefulWidget {
  const WelcomeActivity({Key? key}) : super(key: key);

  @override
  State<WelcomeActivity> createState() => _WelcomeActivityState();
}

class _WelcomeActivityState extends State<WelcomeActivity> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: Components.NavigationBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: screenSize.height * 0.4,
                  width: screenSize.width,
                  child: Image.asset(
                    "assets/images/welcome.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                getEntryContent(),
                Container(
                  height: screenSize.height * 0.17,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.055, horizontal: screenSize.height * 0.01),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(-2, 2), // changes position of shadow
              ),
              ]
            ),
            child: TextButton.icon(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              label: MyText(
                translation(context).home.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: screenSize.width * 0.05,
                ),
              ),
              onPressed: () => {Navigator.of(context).pop()},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(WydColors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column getEntryContent()
  {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07, vertical:  screenSize.width * 0.05),
          alignment: Alignment.topLeft,
          child: MyText(
            translation(context).welcomeTitle,
            style: TextStyle(
              fontSize: screenSize.width * 0.06,
              fontWeight: FontWeight.w500,
              color: WydColors.green,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
          alignment: Alignment.topLeft,
          child: MyText(
            translation(context).welcomeMessage + " 👇🏻",
            style: TextStyle(
              fontSize: screenSize.width * 0.05,
              fontWeight: FontWeight.w500,
              color: WydColors.red,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: screenSize.width * 0.04),
          color: Colors.white,
          height: screenSize.width * 0.55,
          width: screenSize.width * 0.95,
          child: WelcomeCarousel(),
        ),
      ],
    );
  }

}