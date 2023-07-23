import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wyddb23_flutter/Activities/Fatima/Visit/fatima_visit_entry.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;

import '../../../APIs/WydAPI/Models/visit_model.dart';
import '../../../APIs/WydAPI/api_cache_helper.dart';
import '../../../Components/header.dart';
import '../../../Components/my_text.dart';
import '../../../Components/wyd_resources.dart';
import '../../../language_constants.dart';

class FatimaVisitActivity extends StatefulWidget {
  const FatimaVisitActivity({Key? key}) : super(key: key);

  @override
  State<FatimaVisitActivity> createState() => _FatimaVisitActivityState();
}

class _FatimaVisitActivityState extends State<FatimaVisitActivity> {

  late List<Visit>? _visitModel = null;

  @override
  void initState() {
    super.initState();
    _getVisit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getVisit() async {
    _visitModel = (await ApiCacheHelper.getFatimaVisits());
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
            translation(context).fatima.toUpperCase(),
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
      body: Header(
        title: translation(context).visit,
        titleColor: Colors.white,
        color: WydColors.green,
        hasBanner: false,
        content: Container(
          color: Colors.white,
          child: Column(
            children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical:20),
              child: MyText(
                translation(context).fatimaVisitParagraph,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02),
                ),
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing: 25.0,
              children: [
                if(_visitModel != null)...
                {
                  for(Visit visit in _visitModel!)...
                  {
                    getVisitButton(screenSize, visit),
                  }
                }
              ],
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

  Container getVisitButton(Size screenSize, Visit visit)
  {
    return Container(
      child: GestureDetector(
        child: Container(
         decoration: BoxDecoration(
          color: WydColors.yellow,
          borderRadius: BorderRadius.circular(10)
         ),
         margin: EdgeInsets.only(top:20),
         height: screenSize.width * 0.27,
         width: screenSize.width * 0.4,
         child: Stack(
           children: [
            CachedNetworkImage(
              imageUrl: visit.picture,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenSize.width * 0.06,),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.0)]
                )
              ),
            ),
            Container(
              width: screenSize.width * 0.5,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              alignment: Alignment.bottomLeft,
              child: MyText(
              visit.name.toUpperCase(),
              style: TextStyle(
                  letterSpacing: -0.1,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: screenSize.width * 0.04,
                ),
              ),
            ),
           ],
         ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FatimaVisitEntry(visit: visit)),
          );
        }, 
      ),
    );
  }

  Container getBanner(Size screenSize, BuildContext context) {
    return Container(
        height: screenSize.height * 0.05,
        width: screenSize.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
      );
  }
}