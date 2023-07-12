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
import '../Components/accordion_page.dart';

class FollowUsActivity extends StatefulWidget {
  const FollowUsActivity({Key? key}) : super(key: key);

  @override
  State<FollowUsActivity> createState() => _FollowUsActivityState();
}

class _FollowUsActivityState extends State<FollowUsActivity> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  List<Faq>? _faqModel = null;

  @override
  void initState() {
    super.initState();
    _getFaq();
  }

  void _getFaq() async {
    _faqModel = (await ApiCacheHelper.getFaq());
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
                  translation(context).followUs,
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
      height: screenSize.height * 0.7,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20), 
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: screenSize.width * 0.02,
          mainAxisSpacing: screenSize.width * 0.04,
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
    );
  }

  Container getSocialMediaButton(Size screenSize, String asset) {
    return Container(
            height: screenSize.width * 0.45,
            width: screenSize.width * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Positioned(
                    height: screenSize.width * 0.45,
                    width: screenSize.width * 0.45,
                    child: 
                    Image.asset(
                      asset,
                      fit: BoxFit.cover
                    )
                  ),
                ],
              ),
            )
          );
  }
}