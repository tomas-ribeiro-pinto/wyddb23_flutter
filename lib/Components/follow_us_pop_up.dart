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

class FollowUsPopUp {

  Future<void> showSocialDialog(BuildContext context) async {
    Size screenSize = MediaQuery.of(context).size;

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: WydColors.red,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: MyText(
                  translation(context).followUs + '!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
              ),
            ],
          ),
            content:  SizedBox(
              height: screenSize.width * 0.5,
              width: 0,
              child: Center(
                child: Wrap(
                  spacing: screenSize.width * 0.05,
                  runSpacing: screenSize.width * 0.05,
                  children: [
                    GestureDetector(
                      child: getSocialMediaButton(screenSize, "assets/images/instagram.png"),
                      onTap: () => {
                        launchUrl(Uri.parse("https://www.instagram.com/wyddonbosco23"), mode: LaunchMode.externalApplication)
                      },),
                    GestureDetector(
                      child: getSocialMediaButton(screenSize, "assets/images/facebook.png"),
                      onTap: () => {
                        launchUrl(Uri.parse("https://www.facebook.com/wyddonbosco23"), mode: LaunchMode.externalApplication)
                      },),
                    GestureDetector(
                      child: getSocialMediaButton(screenSize, "assets/images/youtube.png"),
                      onTap: () => {
                        launchUrl(Uri.parse("https://www.youtube.com/channel/UCNHL0RbvRX3AwyGSIj1tSMw"), mode: LaunchMode.externalApplication)
                      },),
                    GestureDetector(
                      child: getSocialMediaButton(screenSize, "assets/images/linkedin.png"),
                      onTap: () => {
                        launchUrl(Uri.parse("https://www.linkedin.com/showcase/wyddonbosco23/"), mode: LaunchMode.externalApplication)
                      },),
                  ]
                ),
              ),
            ),
        );
      },
    );
  }

    Container getSocialMediaButton(Size screenSize, String asset) {
    return Container(
      height: screenSize.width * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          asset,
          fit: BoxFit.cover
        ),
      )
    );
  }
}