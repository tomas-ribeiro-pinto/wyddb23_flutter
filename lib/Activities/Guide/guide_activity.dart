import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/new_guide_model.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:accordion/accordion.dart';

import '../../../Components/my_text.dart';
import '../../../Components/wyd_resources.dart';
import '../../APIs/WydAPI/Models/contact_model.dart';
import '../../APIs/WydAPI/Models/faq_model.dart';
import '../../APIs/WydAPI/Models/guide_model.dart';
import '../../APIs/WydAPI/Models/timetable_model.dart';
import '../../APIs/WydAPI/api_cache_helper.dart';
import '../../Components/accordion_page.dart';
import '../../Pdf/permission_request.dart';
import 'guide_entry.dart';

class GuideActivity extends StatefulWidget {
  const GuideActivity({Key? key}) : super(key: key);

  @override
  State<GuideActivity> createState() => _GuideActivityState();
}

class _GuideActivityState extends State<GuideActivity> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  //Map<String, Guide>? _guideModel = null;
  List<List<NewGuide>>? _guideModel = null;

  @override
  void initState() {
    super.initState();
    _getGuides();
  }

  void _getGuides() async {
    //_guideModel = (await ApiCacheHelper.getGuides());
    _guideModel = (await ApiCacheHelper.getGuides());
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
            translation(context).symDay.toUpperCase(),
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
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              decoration: BoxDecoration(
                color: WydColors.green,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                child: MyText(
                  translation(context).guides,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: screenSize.height * 0.04,
                  ),
                ),
              ),
            ),
            getEntryContent()
          ],
        ),
      )
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
          physics: const ClampingScrollPhysics(),
          child: Wrap(
            runSpacing: screenSize.width * 0.02,
            children: [
              /* if(_guideModel != null)...
              {
   
                for(var entry in _guideModel!.keys)...
                {
                  getGuideCard(screenSize, entry, _guideModel?[entry])
                },
                if(_guideModel!.isEmpty)...
                  {
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: HeroIcon(HeroIcons.noSymbol)
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: MyText(
                              translation(context).noRecords,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: WydColors.green,
                                fontSize: screenSize.width * 0.05
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  }
              } */
              if(_guideModel != null)...
              {
   
                for(List<NewGuide> entry in _guideModel!)...
                {
                  getGuideCard(screenSize, entry[0])
                },
                if(_guideModel!.isEmpty)...
                  {
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: HeroIcon(HeroIcons.noSymbol)
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: MyText(
                              translation(context).noRecords,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: WydColors.green,
                                fontSize: screenSize.width * 0.05
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  }
              }
              else...
              {
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyText(
                        translation(context).loading + '...',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: WydColors.green,
                          fontSize: 20
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: CircularProgressIndicator( //Adds a Loading Indicator
                          color: WydColors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
              },
            ],
          ),
        )
      ),
    );
  }

  Container getGuideCard(Size screenSize, NewGuide? guide) {
    return Container(
      child: Container(
        constraints: BoxConstraints(
          minHeight: screenSize.width * 0.2,
        ),
        width: screenSize.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.1,
              blurRadius: 10
            )
          ]
        ),
        child: TextButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GuideEntry(title: guide.getTranslatedTitleAttribute(currentLanguageCode), body: guide.getTranslatedBodyAttribute(currentLanguageCode))),
            )
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenSize.width * 0.12,
                margin: EdgeInsets.only(left: 20),
                child: HeroIcon(
                  HeroIcons.document,
                  style: HeroIconStyle.solid,
                  color: Colors.grey[800],
                )
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: MyText(
                  guide!.getTranslatedTitleAttribute(currentLanguageCode),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.03, screenSize.height * 0.025, screenSize.height * 0.025),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container getOldGuideCard(Size screenSize, String filepath, Guide? guide) {
    return Container(
      child: Container(
        constraints: BoxConstraints(
          minHeight: screenSize.width * 0.2,
        ),
        width: screenSize.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.1,
              blurRadius: 20
            )
          ]
        ),
        child: TextButton(
          onPressed: () => {
          PermissionRequest.requestPermission(context, filepath, guide.getTranslatedTitleAttribute(currentLanguageCode))
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenSize.width * 0.12,
                margin: EdgeInsets.only(left: 20),
                child: HeroIcon(
                  HeroIcons.document,
                  style: HeroIconStyle.solid,
                  color: Colors.grey[800],
                )
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: MyText(
                  guide!.getTranslatedTitleAttribute(currentLanguageCode),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.03, screenSize.height * 0.025, screenSize.height * 0.025),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}