import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../Components/my_text.dart';
import '../../Components/wyd_resources.dart';

class WelcomeRector extends StatefulWidget {
  const WelcomeRector({Key? key, required this.locale}) : super(key: key);

  final String locale;

  @override
  State<WelcomeRector> createState() => _WelcomeRectorState();
}

class _WelcomeRectorState extends State<WelcomeRector> {
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
  return await rootBundle.loadString('assets/content/welcome/rector_welcome' + '_' + widget.locale +'.html');
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
            translation(context).welcome.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: WydColors.red,
              fontSize: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        ),
        backgroundColor: WydColors.yellow,
        surfaceTintColor: WydColors.yellow,
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: translation(context).rectorMessageTitle,
        titleColor: Colors.black,
        color: WydColors.yellow,
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
                  style: WydResources.htmlStyle(context),
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

}