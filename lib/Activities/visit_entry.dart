import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../APIs/WydAPI/Models/visit_model.dart';
import '../Components/my_text.dart';

class VisitEntry extends StatefulWidget {
  const VisitEntry({Key? key, required this.visit}) : super(key: key);

  final Visit visit;

  @override
  State<VisitEntry> createState() => _VisitEntryState();
}

class _VisitEntryState extends State<VisitEntry> {
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          label: MyText(
            translation(context).visit.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFFd53f28),
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
        title: widget.visit.name,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    color: Color(0xFFf6be18),
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: screenSize.height * 0.2,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.visit.picture,
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    widget.visit.addressLine1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: screenSize.height * 0.02,
                                    ),
                                  ),
                                  MyText(
                                    widget.visit.addressLine2,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: screenSize.height * 0.02,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                              child: IconButton(
                                icon: HeroIcon(HeroIcons.mapPin, color: Colors.white),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    return Color(0xFFd53f28);
                                  }),
                                ),
                                onPressed: () => MapsLauncher.launchQuery(widget.visit.addressLine1 +  ' ' + widget.visit.addressLine2),
                              ),
                            ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),        
            getEntryDescription(),
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
        padding: EdgeInsets.only(top: 30),
        child: Wrap(
          runSpacing: 20,
          children: [
            MyText(
              widget.visit.getTranslatedDescriptionAttribute(currentLanguageCode),
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