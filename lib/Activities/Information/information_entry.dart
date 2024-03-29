import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../Components/my_text.dart';
import '../../Components/wyd_resources.dart';

class InformationEntry extends StatefulWidget {
  const InformationEntry({Key? key, required this.title, required this.body}) : super(key: key);

  final String title;
  final String body;

  @override
  State<InformationEntry> createState() => _InformationEntryState();
}

class _InformationEntryState extends State<InformationEntry> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;

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
      body: Header(
        title: widget.title,
        titleColor: Colors.white,
        color: WydColors.red,
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
                  data: addBreaks(widget.body),
                  style: WydResources.htmlStyle(context),
                  onLinkTap:(url, attributes, element) {
                    launchUrl(Uri.parse(url!), mode: LaunchMode.externalApplication);
                  },
                ),
              Container(
                height: screenSize.height * 0.17,
              )
              ],
            ),
      ),
      ),
    );
  }

  String addBreaks(String html)
  {
    return html.replaceAll("</div>", "<div><br>");
  }
}