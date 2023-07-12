import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:accordion/accordion.dart';

import '../../Components/accordion_page.dart';
import '../../Components/my_text.dart';
import '../../Components/wyd_resources.dart';

class InformationHealth extends StatefulWidget {
  const InformationHealth({Key? key}) : super(key: key);

  @override
  State<InformationHealth> createState() => _InformationHealthState();
}

class _InformationHealthState extends State<InformationHealth> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  Map<String, String> htmlData = {};

  @override
  void initState() {
    super.initState();
    loadAsset().then((value) {
      setState(() {
        htmlData = value;
      });
    });
  }

Future<Map<String, String>> loadAsset() async {
  Map<String, String> assets = {};

  assets['header'] = await rootBundle.loadString('assets/content/health/health_advice.html');
  assets['section1'] = await rootBundle.loadString('assets/content/health/health_advice_section1.html');
  assets['section2'] = await rootBundle.loadString('assets/content/health/health_advice_section2.html');
  assets['section3'] = await rootBundle.loadString('assets/content/health/health_advice_section3.html');
  assets['inter_section'] = await rootBundle.loadString('assets/content/health/health_advice_inter_section.html');
  assets['section4'] = await rootBundle.loadString('assets/content/health/health_advice_section4.html');
  assets['section5'] = await rootBundle.loadString('assets/content/health/health_advice_section5.html');
  assets['section6'] = await rootBundle.loadString('assets/content/health/health_advice_section6.html');
  assets['section7'] = await rootBundle.loadString('assets/content/health/health_advice_section7.html');
  assets['section8'] = await rootBundle.loadString('assets/content/health/health_advice_section8.html');
  assets['section9'] = await rootBundle.loadString('assets/content/health/health_advice_section9.html');
  assets['section10'] = await rootBundle.loadString('assets/content/health/health_advice_section10.html');

  return assets;
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
            translation(context).information.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: WydColors.yellow,
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
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              decoration: BoxDecoration(
                color: WydColors.red,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                child: MyText(
                  translation(context).health,
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
        child: /* SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:  */Column(
              children: [
              SingleChildScrollView(
                child: !htmlData.isEmpty 
                       ? AccordionPage().getHealthAccordion(context, htmlData)
                       : Container()),
              Container(
                height: screenSize.height * 0.17,
              )
              ],
            ),
/*       ), */
      ),
    );
  }
}