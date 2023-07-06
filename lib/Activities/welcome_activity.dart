import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Components/my_text.dart';
import '../Components/rounded_card.dart';

class WelcomeActivity extends StatefulWidget {
  const WelcomeActivity({Key? key}) : super(key: key);

  @override
  State<WelcomeActivity> createState() => _WelcomeActivityState();
}

class _WelcomeActivityState extends State<WelcomeActivity> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  String htmlData = "";

  @override
  void initState() {
    super.initState();
    loadAsset().then((value) {
      setState(() {
        htmlData = value;
      });
    });
  }

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/content/wyd_welcome.html');
}

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: Components.NavigationBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenSize.height * 0.4,
                  width: screenSize.width,
                  child: Image.asset(
                    "assets/images/welcome.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.055, horizontal: screenSize.height * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                      color: Colors.black.withOpacity(0.6),
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
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF028744)),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07, vertical:  screenSize.width * 0.05),
              alignment: Alignment.topLeft,
              child: MyText(
                translation(context).welcomeParagraph,
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            getEntryContent(),
          ],
        ),
      ),
    );
  }

  Container getEntryContent()
  {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(20), 
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 10,
            children: [
              roundedCard(imageUrl: "assets/images/reitor-mor.jpg"),
              roundedCard(imageUrl: "assets/images/madre-geral.jpg"),
              roundedCard(imageUrl: "assets/images/wyd-welcome.png"),
            ],
          ),
        ),
      ),
    );
  }

}