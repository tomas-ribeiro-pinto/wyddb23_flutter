import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
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
import 'information_entry.dart';
import 'information_transport.dart';

class InformationActivity extends StatefulWidget {
  const InformationActivity({Key? key}) : super(key: key);

  @override
  State<InformationActivity> createState() => _InformationActivityState();
}

class _InformationActivityState extends State<InformationActivity> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  List<List<Information>>? _informationModel = null;

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
              color: Colors.white,
              fontSize: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        ),
        backgroundColor: WydColors.red,
        surfaceTintColor: WydColors.red,
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: translation(context).information,
        titleColor: Colors.white,
        color: WydColors.red,
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
              translation(context).informationParagraph,
              style: TextStyle(
                fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02,  screenSize.height * 0.02),
                fontWeight: FontWeight.w400,
                color: Colors.black,
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
                    MaterialPageRoute(builder: (context) => InformationHealth(locale: currentLanguageCode,)),
                  )
                },
              ),
              if(_informationModel != null)...
              {
                for(List<Information> information in _informationModel!)...
                {
                  getInformationButton(information[0]),
                }
              }
            ],
          )
        ],
      ),
    );
  }

  GestureDetector getInformationButton(Information information) {
    return GestureDetector(
            child: roundedCard(
              imageUrl: information.imageUrl,
              title: information.getTranslatedTitleAttribute(currentLanguageCode),
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