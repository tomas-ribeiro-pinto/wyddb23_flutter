import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:wyddb23_flutter/Activities/Fatima/Guide/fatima_guide_activity.dart';
import 'package:wyddb23_flutter/Activities/Fatima/Visit/fatima_visit_activity.dart';
import 'package:wyddb23_flutter/Activities/Information/information_health.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/Components/wyd_resources.dart';
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../APIs/WydAPI/Models/information_model.dart';
import '../../APIs/WydAPI/api_cache_helper.dart';
import '../../Components/my_text.dart';
import '../../Components/rounded_card.dart';

class FatimaActivity extends StatefulWidget {
  const FatimaActivity({Key? key}) : super(key: key);

  @override
  State<FatimaActivity> createState() => _FatimaActivityState();
}

class _FatimaActivityState extends State<FatimaActivity> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
        transform:  Matrix4.translationValues(-20.0, 0.0, 0.0),
          child: TextButton.icon(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          label: MyText(
            translation(context).home.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: WydColors.yellow,
              fontSize: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        ),
        backgroundColor: WydColors.green,
        surfaceTintColor: WydColors.green,
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: translation(context).fatima,
        titleColor: Colors.white,
        color: WydColors.green,
        content: getEntryContent(),
        hasBanner: false,
      ),
    );
  }

  Container getEntryContent()
  {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07, vertical:  screenSize.width * 0.05),
            alignment: Alignment.topLeft,
            child: MyText(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrudaute.",
              style: TextStyle(
                fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02,  screenSize.height * 0.02),
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          Flex(
            direction: Axis.vertical, 
            children: [
              getButton(screenSize, translation(context).guides, context, () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FatimaGuideActivity()),
                )
              }),
              getButton(screenSize, translation(context).visit, context, () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FatimaVisitActivity()),
                )
              })
            ]
          ),
        ],
      ),
    );
  }

  Container getButton(Size screenSize, String action, BuildContext context, Function() onPressed) {
    return Container(
      margin: EdgeInsets.only(top:15),
      child: Material(
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenSize.width * 0.13),
            )),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return WydColors.green;
            }),
          ),
          onPressed: onPressed,
          child: Container(
            width: screenSize.width * 0.7,
            alignment: Alignment.center,
            child: MyText(
            action.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: screenSize.height * 0.025,
              ),
            ),
          ),
        ),
      ),
    );
  }
}