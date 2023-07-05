import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';

import '../APIs/WydAPI/Models/day_model.dart';
import '../Components/my_text.dart';
import 'location_entry.dart';

class AccommodationLocation extends StatefulWidget {
  const AccommodationLocation({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  State<AccommodationLocation> createState() => _AccommodationLocationState();
}

class _AccommodationLocationState extends State<AccommodationLocation> {

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
            child: MyText(
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
      child: Column(
        children: [
          Container(
          margin: EdgeInsets.all(20),
          child: MyText(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: screenSize.height * 0.02,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            runSpacing: 15,
            children: [
              getLocationButton(screenSize, "Salesianos de Lisboa"),
              getLocationButton(screenSize, "Salesianos de Lisboa"),
              getLocationButton(screenSize, "Salesianos de Lisboa"),
              getLocationButton(screenSize, "Salesianos de Lisboa"),
            ],
          ),
        ),
        Container(
          height: 150,
          color: Colors.transparent,
        ),
        ],
      ),
    );
  }

  Container getLocationButton(Size screenSize, String site) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 0)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return Colors.green;
              return Color(0xFF028744);
            }),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocationEntry(location: widget.location, site: site)),
            );
          }, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: screenSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/salesianos_lisboa.jpg",
                  fit: BoxFit.cover,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: MyText(
                "Salesianos Lisboa",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: screenSize.height * 0.02,
                ),
              ),
            ),
          ],
        ),
        ),
      );
  }

}