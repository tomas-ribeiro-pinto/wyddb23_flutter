import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/new_guide_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/timetable_model.dart';
import 'package:wyddb23_flutter/Activities/Timetable/timetable_entry.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/Notifications/notification_service.dart';
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:accordion/accordion.dart';

import '../../../Components/my_text.dart';
import '../../../Components/wyd_resources.dart';
import '../../APIs/WydAPI/Models/contact_model.dart';
import '../../APIs/WydAPI/Models/faq_model.dart';
import '../../APIs/WydAPI/Models/guide_model.dart';
import '../../APIs/WydAPI/api_cache_helper.dart';
import '../../Components/accordion_page.dart';
import '../../Pdf/permission_request.dart';

class TimetableActivity extends StatefulWidget {
  const TimetableActivity({Key? key}) : super(key: key);

  @override
  State<TimetableActivity> createState() => _TimetableActivityState();
}

class _TimetableActivityState extends State<TimetableActivity> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  List<Timetable>? _timetableModel = null;
  List<int>? alarms = [];

  @override
  void initState() {
    super.initState();
    _getTimetable();
  }

  void _getTimetable() async {
    _timetableModel = (await ApiCacheHelper.getTimetable()).values.toList();
    alarms = (await NotificationService.getAlarms())!.cast<int>();
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
                  translation(context).timetable,
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
          child: 
          _timetableModel != null
          ?
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
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
              child: Wrap(
                children: [
                  for(Timetable entry in _timetableModel!)...
                  {
                    getTimetableEntry(screenSize, entry as Timetable?)
                  },
                ],
              ),
            )
          :
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  margin: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator( //Adds a Loading Indicator
                    color: WydColors.yellow,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Container getTimetableEntry(Size screenSize, Timetable? entry) {
    DateFormat formatter = DateFormat('HH:mm');

    bool alert = alarms!.contains(entry!.id) ? true : false;

    return Container(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: screenSize.width * 0.2,
            ),
            width: screenSize.width * 0.9,
            child:  TextButton(
              onPressed: () async => {
                 await TimetableEntry.showTimetableDialog(context,
                  currentLanguageCode,
                  entry,
                  alert),
                  setState(() {
                    _getTimetable();
                  })
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: screenSize.width * 0.02),
                    child: MyText(
                      entry!.startTime != null ? formatter.format(entry.startTime!) : '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: WydColors.green,
                        fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: screenSize.width * 0.03),
                          child: MyText(
                            entry!.getTranslatedTitleAttribute(currentLanguageCode),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: screenSize.width * 0.02),
                                child: HeroIcon(
                                  HeroIcons.mapPin,
                                  style: HeroIconStyle.solid,
                                  color: Colors.grey[400],
                                  size: 18,
                                )
                              ),
                              Container(
                                child: MyText(
                                  entry.location,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800],
                                    fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.02, screenSize.height * 0.017, screenSize.height * 0.017),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  alert == true 
                  ?
                    Container(
                      height: screenSize.width * 0.12,
                      margin: EdgeInsets.only(right: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.02, screenSize.height * 0.02, screenSize.height * 0.02)),
                      child: HeroIcon(
                        HeroIcons.bell,
                        style: HeroIconStyle.solid,
                        color: WydColors.red,
                      )
                    )
                  :
                    Container(
                      height: screenSize.width * 0.12,
                      width: screenSize.width * 0.12,
                      margin: EdgeInsets.only(right: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.02, screenSize.height * 0.02, screenSize.height * 0.02)),
                    ),
                ],
              ),
            ),
          ),
          if(_timetableModel!.indexOf(entry!) != _timetableModel!.length - 1)...
          {
            Divider(
              color: Colors.grey.withOpacity(0.2),
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
          }
        ],
      ),
    );
  }
}