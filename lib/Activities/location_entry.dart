import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';

import '../APIs/WydAPI/day_model.dart';

class LocationEntry extends StatefulWidget {
  const LocationEntry({Key? key, required this.location, required this.site}) : super(key: key);

  final String location;
  final String site;

  @override
  State<LocationEntry> createState() => _LocationEntryState();
}

class _LocationEntryState extends State<LocationEntry> {
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
          transform:  Matrix4.translationValues(-30.0, 0.0, 0.0),
          child: GestureDetector(
            onTap: () => {Navigator.of(context).pop()},
            child: Text(
              translation(context).accommodation.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFFf6be18),
                fontSize: screenSize.width * 0.05,
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFF028744),
        surfaceTintColor: Color(0xFF028744),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: widget.location.toUpperCase(),
        color: Color(0xFF028744),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  widget.site,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF028744),
                    fontSize: screenSize.width * 0.08 
                  ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HeroIcon(
                          HeroIcons.mapPin,
                          style: HeroIconStyle.solid,
                          color: Color(0xFFd53f28),
                          size: 23,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                              "Praça São João Bosco, 34",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: screenSize.width * 0.05 
                              ),
                              ),
                              Text(
                              "1399-007, Lisboa",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: screenSize.width * 0.05 
                              ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  getEntryDescription()
                ],
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

  Container getEntryDescription()
  {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          style: TextStyle(
          fontSize: screenSize.width * 0.04 
          ),
        ),
      ),
    );
  }

}