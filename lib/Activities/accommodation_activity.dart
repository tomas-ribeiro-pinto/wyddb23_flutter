import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';

import '../APIs/WydAPI/Models/accommodation_model.dart';
import '../APIs/WydAPI/Models/agenda_model.dart';
import '../APIs/WydAPI/api_cache_helper.dart';
import '../Components/my_text.dart';
import 'accommodation_entry.dart';

class AccommodationActivity extends StatefulWidget {
  const AccommodationActivity({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  State<AccommodationActivity> createState() => _AccommodationActivityState();
}

class _AccommodationActivityState extends State<AccommodationActivity> {

  String get currentLanguageCode => Localizations.localeOf(context).languageCode;

  late List<Accommodation>? _accommodationModel = null;

  @override
  void initState() {
    super.initState();
    _getAccommodation();
  }

  void _getAccommodation() async {
    _accommodationModel = (await ApiCacheHelper.getAccommodation(widget.location));
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
              if(_accommodationModel != null)...
              {
                for(Accommodation accommodation in _accommodationModel!)...
                {
                  getLocationButton(screenSize, accommodation),
                },
                if(_accommodationModel!.isEmpty)...
                {
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: HeroIcon(HeroIcons.noSymbol)
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: MyText(
                            translation(context).noRecords,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF028744),
                              fontSize: screenSize.width * 0.05
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                }
              }
              else...
              {
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        translation(context).loading + '...',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF028744),
                          fontSize: 20
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator( //Adds a Loading Indicator
                          color: Color(0xFFf6be18),
                        ),
                      ),
                    ],
                  ),
                ),
              }
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

  Container getLocationButton(Size screenSize, Accommodation accommodation) {
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
              return Color(0xFF028744);
            }),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccommodationEntry(accommodation: accommodation)),
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
                child: CachedNetworkImage(
                  imageUrl: accommodation.picture,
                  fit: BoxFit.cover,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: MyText(
                accommodation.name,
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