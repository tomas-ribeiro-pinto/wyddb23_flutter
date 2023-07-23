import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/Notifications/notification.dart' as notification;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:accordion/accordion.dart';

import '../../Components/my_text.dart';
import '../../Components/wyd_resources.dart';
import '../APIs/WydAPI/Models/faq_model.dart';
import '../APIs/WydAPI/api_cache_helper.dart';
import 'accordion_page.dart';

class NotificationPopUp {

  Future<void> showNotificationDialog(BuildContext context, notification.Notification notification) async {
    Size screenSize = MediaQuery.of(context).size;
    print(notification.payLoad);

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(notification.title.toString(), 
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
                            // Get Body
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: MyText(
                                  notification.body.toString(),
                                  style: TextStyle(
                                    fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02)
                                  ),
                                ),
                              ),
                            ),
                          if(notification.payLoad != null)...
                            {
                              if(notification.payLoad!.containsKey('url'))...
                              {
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: WydColors.red,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(translation(context).openLink, style: TextStyle(color: Colors.white),)
                                    ),
                                    onPressed: () {
                                      launchUrl(Uri.parse(notification.payLoad!['url']), mode: LaunchMode.externalApplication);
                                    }
                                  ),
                                ),
                              }
                            }
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        );
      }
    );
  }
}