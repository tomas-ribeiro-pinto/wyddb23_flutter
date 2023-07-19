import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/timetable_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_cache_helper.dart';
import 'package:wyddb23_flutter/Components/my_text.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wyddb23_flutter/Notifications/notification_service.dart';
import 'package:wyddb23_flutter/language_constants.dart';


class TimetableEntry{

  static Future<void> showTimetableDialog(BuildContext context, String currentLanguageCode, Timetable entry, bool alert) async {
    Size screenSize = MediaQuery.of(context).size;
    DateFormat formatter = DateFormat('HH:mm');

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(entry.getTranslatedTitleAttribute(currentLanguageCode), 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.03, screenSize.height * 0.025, screenSize.height * 0.025)),),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: HeroIcon(
                          HeroIcons.xCircle,
                          color: Colors.green,
                          style: HeroIconStyle.solid,
                          size: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.05, screenSize.height * 0.04, screenSize.height * 0.04)
                        ),
                      )
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  thickness: 2,
                ),
              ],
            ),
            content:  Container(
              width: screenSize.width,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  entry.endTime != null
                                        ? formatter.format(entry.startTime!) + ' - ' + formatter.format(entry.endTime!) 
                                        : formatter.format(entry.startTime!),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: WydColors.green,
                                    fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.03, screenSize.height * 0.025, screenSize.height * 0.025)
                                  ),
                                ),
                                Row(
                                  children: [
                                    HeroIcon(
                                      HeroIcons.mapPin,
                                      style: HeroIconStyle.solid,
                                      color: Colors.grey[400],
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2.0),
                                        child: MyText(
                                        entry.location,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02)
                                        ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Get Description
                                if(entry.getTranslatedDescriptionAttribute(currentLanguageCode) != 'null')...
                                {
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: MyText(
                                        entry.getTranslatedDescriptionAttribute(currentLanguageCode),
                                        style: TextStyle(
                                          fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02)
                                        ),
                                      ),
                                    ),
                                  ),
                                }
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: alert == false
            ?
            <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(translation(context).createAlert, 
                          style: TextStyle(color: WydColors.red, fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02)),),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: HeroIcon(
                            HeroIcons.bell,
                            style: HeroIconStyle.solid,
                            color: WydColors.red,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if(entry.startTime != null)
                      {
                        NotificationService().scheduleNotification(
                          title: translation(context).alertTitle,
                          body: "'${entry.getTranslatedTitleAttribute(currentLanguageCode)}' " + translation(context).alertParagraph,
                          scheduleNotificationDateTime: DateTime(2023,8,2, entry.startTime!.subtract(Duration(minutes: 5)).hour, entry.startTime!.subtract(Duration(minutes: 5)).minute, entry.startTime!.second) 
                        );
                        NotificationService.saveAlarm(entry.id);
                        setState(() => alert = true);
                        var message = SnackBar(content: Text(translation(context).alertCreated));
                        ScaffoldMessenger.of(context).showSnackBar(message);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ]
            :
            <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(translation(context).alertCreated, style: TextStyle(color: WydColors.red),),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: HeroIcon(
                          HeroIcons.bell,
                          style: HeroIconStyle.solid,
                          color: WydColors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}