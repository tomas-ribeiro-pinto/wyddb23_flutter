import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class FaqActivity extends StatefulWidget {
  const FaqActivity({Key? key}) : super(key: key);

  @override
  State<FaqActivity> createState() => _FaqActivityState();
}

class _FaqActivityState extends State<FaqActivity> {
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
                  translation(context).faq,
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
        child: AccordionPage().getFaqAccordion(context, _faqModel, currentLanguageCode)
      ),
    );
  }
}