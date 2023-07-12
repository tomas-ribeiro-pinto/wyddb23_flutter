import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:wyddb23_flutter/Activities/Information/information_health.dart';
import 'package:wyddb23_flutter/Components/carousel.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/Components/wyd_resources.dart';
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../APIs/WydAPI/Models/information_model.dart';
import '../../APIs/WydAPI/api_cache_helper.dart';
import '../../Components/my_text.dart';
import '../../Components/rounded_card.dart';
import 'information_entry.dart';
import 'information_transport.dart';

class InformationActivity extends StatefulWidget {
  const InformationActivity({Key? key}) : super(key: key);

  @override
  State<InformationActivity> createState() => _InformationActivityState();
}

class _InformationActivityState extends State<InformationActivity> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  List<Information>? _informationModel = null;

  @override
  void initState() {
    super.initState();
    _getInformation();
  }

  void _getInformation() async {
    _informationModel = (await ApiCacheHelper.getInformation());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

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
                  height: screenSize.height * 0.3,
                  width: screenSize.width,
                  child: Image.asset(
                    "assets/images/information.jpg",
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
                backgroundColor: MaterialStatePropertyAll<Color>(WydColors.red),
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
            translation(context).information,
            style: TextStyle(
              fontSize: screenSize.width * 0.08,
              fontWeight: FontWeight.w500,
              color: WydColors.green,
            ),
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            GestureDetector(
              child: roundedCard(
                imageAsset: "assets/images/health.jpg",
                title: translation(context).health,
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InformationHealth()),
                )
              },
            ),
            if(_informationModel != null)...
            {
              for(Information information in _informationModel!)...
              {
                getInformationButton(information),
              }
            }
          ],
        )
      ],
    );
  }

  GestureDetector getInformationButton(Information information) {
    return GestureDetector(
            child: roundedCard(
              imageUrl: information.imageUrl,
              title: translation(context).transport,
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformationEntry(title: information.getTranslatedTitleAttribute(currentLanguageCode), body: information.getTranslatedBodyAttribute(currentLanguageCode))),
              )
            },
          );
  }

}