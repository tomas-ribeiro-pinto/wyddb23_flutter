import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:wyddb23_flutter/Activities/Welcome/welcome_mother.dart';
import 'package:wyddb23_flutter/Activities/Welcome/welcome_rector.dart';
import 'package:wyddb23_flutter/Activities/Welcome/welcome_wyd.dart';
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
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
        transform:  Matrix4.translationValues(-20.0, 0.0, 0.0),
          child: TextButton.icon(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          label: MyText(
            translation(context).home.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: WydColors.red,
              fontSize: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        ),
        backgroundColor: WydColors.yellow,
        surfaceTintColor: WydColors.yellow,
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: translation(context).welcome,
        titleColor: Colors.black,
        color: WydColors.yellow,
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
      child: Padding(
        padding: EdgeInsets.all(20), 
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                runSpacing: 15,
                children: [
                  getWelcomeButton(screenSize,
                    'assets/images/reitor-mor.jpg', 
                    translation(context).rectorMessage,
                    WelcomeRector(locale: currentLanguageCode)),
                  getWelcomeButton(screenSize,
                    'assets/images/madre-geral.jpg', 
                    translation(context).motherMessage,
                    WelcomeMother(locale: currentLanguageCode)),
                  getWelcomeButton(screenSize,
                    'assets/images/wyd-welcome.png', 
                    translation(context).wydMessage,
                    WelcomeWyd(locale: currentLanguageCode))
                ],
              ),
              Container(
                height: screenSize.height * 0.17,
              )
           ],
          ),
        ),
      ),
    );
  }

  Container getWelcomeButton(Size screenSize, String image, String title, dynamic activity)
  {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 0)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return WydColors.yellow;
            }),
          ),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => activity),
            )
          }, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenSize.width * 0.4,
              width: screenSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: MyText(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02),
                ),
              ),
            ),
          ],
        ),
        ),
      );
  }

}