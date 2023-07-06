import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Components/my_text.dart';

class WelcomeEntry extends StatefulWidget {
  const WelcomeEntry({Key? key}) : super(key: key);

  @override
  State<WelcomeEntry> createState() => _WelcomeEntryState();
}

class _WelcomeEntryState extends State<WelcomeEntry> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  String htmlData = "";

  @override
  void initState() {
    super.initState();
    loadAsset().then((value) {
      setState(() {
        htmlData = value;
      });
    });
  }

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/content/wyd_welcome.html');
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          label: MyText(
            translation(context).home.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF028744),
              fontSize: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        ),
        backgroundColor: Color(0xFFf6be18),
        surfaceTintColor: Color(0xFFf6be18),
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: translation(context).welcome,
        titleColor: Colors.black,
        color: Color(0xFFf6be18),
        content: getEntryContent(),
        hasBanner: false,
      ),
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
            child: Column(
              children: [
                Html(
                  data: htmlData,
                  style: {
                    'h2': Style(fontSize: FontSize(screenSize.width * 0.045)),
                    'p': Style(fontSize: FontSize(screenSize.width * 0.04)),
                  },
                ),
                Container(
                  height: 150,
                  color: Colors.transparent,
                ),
              ],
            ),
      ),
      ),
    );
  }

}