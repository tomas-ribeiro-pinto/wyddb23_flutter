import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../APIs/WydAPI/Models/accommodation_model.dart';
import '../APIs/WydAPI/Models/agenda_model.dart';
import '../Components/my_text.dart';

class AccommodationEntry extends StatefulWidget {
  const AccommodationEntry({Key? key, required this.accommodation}) : super(key: key);

  final Accommodation accommodation;

  @override
  State<AccommodationEntry> createState() => _AccommodationEntryState();
}

class _AccommodationEntryState extends State<AccommodationEntry> {
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
            translation(context).accommodation.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: const Color(0xFFf6be18),
              fontSize: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        ),
        backgroundColor: Color(0xFF028744),
        surfaceTintColor: Color(0xFF028744),
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: widget.accommodation.location.toUpperCase(),
        titleColor: Colors.white,
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
                  MyText(
                  widget.accommodation.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF028744),
                    fontSize: screenSize.width * 0.08 
                  ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:15),
                    child: Column(
                      children: [
                        Row(
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
                                  MyText(
                                  widget.accommodation.addressLine1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: screenSize.width * 0.05 
                                  ),
                                  ),
                                  MyText(
                                  widget.accommodation.addressLine2,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              HeroIcon(
                                HeroIcons.phone,
                                style: HeroIconStyle.solid,
                                color: Color(0xFFd53f28),
                                size: 23,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                    widget.accommodation.contact,
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
        child: Wrap(
          runSpacing: 20,
          children: [
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 20,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFFd53f28);
                      }),
                    ),
                    onPressed: () => MapsLauncher.launchQuery(widget.accommodation.addressLine1 + ' ' + widget.accommodation.addressLine2),
                    child: Container(
                      width: screenSize.width * 0.4,
                      alignment: Alignment.center,
                      child: MyText(
                      translation(context).seeMap.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: screenSize.height * 0.02,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFF028744);
                      }),
                    ),
                    onPressed: () {
                      launchUrl(Uri.parse('tel:' + widget.accommodation.contact));
                    },
                    child: Container(
                      width: screenSize.width * 0.4,
                      alignment: Alignment.center,
                      child: MyText(
                      translation(context).call.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: screenSize.height * 0.02,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MyText(
              widget.accommodation.getTranslatedDescriptionAttribute(currentLanguageCode) != null
              ? widget.accommodation.getTranslatedDescriptionAttribute(currentLanguageCode)
              : '',
              style: TextStyle(
                fontSize: screenSize.width * 0.04 
                ),
              ),
          ],
        ),
      ),
    );
  }

}