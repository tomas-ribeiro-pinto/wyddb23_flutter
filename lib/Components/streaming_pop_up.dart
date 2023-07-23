import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:accordion/accordion.dart';

import '../../Components/my_text.dart';
import '../../Components/wyd_resources.dart';
import '../APIs/WydAPI/Models/faq_model.dart';
import '../APIs/WydAPI/api_cache_helper.dart';
import 'accordion_page.dart';

class StreamingPopUp {

  Future<void> showStreamingDialog(BuildContext context, String? url) async {
    Size screenSize = MediaQuery.of(context).size;

    if(url != null)
    {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
    else
    {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content:  Container(
              padding: EdgeInsets.only(top: screenSize.width * 0.05),
              child: MyText(
                translation(context).nothingHere,
                style: TextStyle(
                  color: WydColors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02)
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(translation(context).close, style: TextStyle(color: Colors.black),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}