import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:http/http.dart';
import 'package:lit_relative_date_time/controller/relative_date_format.dart';
import 'package:lit_relative_date_time/model/relative_date_time.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/notification_model.dart';
import 'package:wyddb23_flutter/Components/my_text.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';
import 'package:wyddb23_flutter/Notifications/notification.dart' as notification;
import 'package:wyddb23_flutter/language_constants.dart';

import 'notification_pop_up.dart';

class NotificationModal{
  //void showModal(BuildContext context, List<notification.Notification> notifications) async
  void showModal(BuildContext context, List<SentNotification> notifications) async
  {
    Size screenSize = MediaQuery.of(context).size;

    await showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      context: context,
      showDragHandle: true,
      builder: (context) => SizedBox(
        height: screenSize.height / 2,
        width: screenSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: WydColors.yellow,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: MyText(
                      translation(context).notificationCentre,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.035, screenSize.height * 0.03, screenSize.height * 0.03)
                      ),
                      ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03, vertical: screenSize.width * 0.05),
                height: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.4, screenSize.height * 0.45, screenSize.height * 0.45),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    children: [
                      for(SentNotification entry in notifications)...
                      {
                        getNotificationCard(context, screenSize, entry),
                      },
                      if(notifications.isEmpty)...
                      {
                        Center(
                          child: MyText(
                            translation(context).noRecords,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis,
                              fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.02, screenSize.height * 0.018, screenSize.height * 0.018),
                            ),
                          ),
                        )
                      }
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Container getNotificationCard(BuildContext context, Size screenSize, SentNotification entry) {
    String currentLanguageCode = Localizations.localeOf(context).languageCode;

    RelativeDateFormat relativeDateFormatter = RelativeDateFormat(
        Localizations.localeOf(context),
    );
    RelativeDateTime relativeDateTime =
      RelativeDateTime(dateTime: DateTime.now(), other: entry.createdAt as DateTime);

    return Container(
      padding: EdgeInsets.all(5),
      child: Container(
        constraints: BoxConstraints(
          minHeight: screenSize.width * 0.2,
        ),
        width: screenSize.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400)
        ),
        child: TextButton(
          onPressed: () => {
            NotificationPopUp().showNotificationDialog(context, entry)
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: screenSize.width * 0.47,
                    child: MyText(
                      entry.getTranslatedTitleAttribute(currentLanguageCode).toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: screenSize.width * 0.5,
                    child: MyText(
                      entry.getTranslatedBodyAttribute(currentLanguageCode).toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis,
                        fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.02, screenSize.height * 0.018, screenSize.height * 0.018),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: MyText(
                  relativeDateFormatter.format(relativeDateTime),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: WydColors.green,
                    fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.02, screenSize.height * 0.018, screenSize.height * 0.018),
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