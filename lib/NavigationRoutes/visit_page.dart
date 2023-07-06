import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../APIs/WydAPI/Models/visit_model.dart';
import '../APIs/WydAPI/api_cache_helper.dart';
import '../Activities/visit_entry.dart';
import '../Components/my_text.dart';
import '../language_constants.dart';

class VisitPage extends StatefulWidget {
  const VisitPage({Key? key}) : super(key: key);

  @override
  State<VisitPage> createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {

  late List<Visit>? _visitModel = null;

  @override
  void initState() {
    super.initState();
    _getVisit();
  }

  void _getVisit() async {
    _visitModel = (await ApiCacheHelper.getVisit());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color:Color(0xFFf6be18),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              getBanner(screenSize, context),
              StickyHeader(
                header: Stack(
                  children: [
                    Container(
                      color: Color(0xFFf6be18),
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                        child: MyText(
                          translation(context).visit.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: screenSize.height * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                content: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: MyText(
                        translation(context).visitParagraph,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: screenSize.height * 0.02,
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
                      height: 150,
                      color: Colors.transparent,
                    ),
                  ],
                              ),
                ),
              ),
            ],
          )
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
          color: Colors.amber,
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
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.0)]
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
                  color: Colors.black,
                  fontSize: screenSize.width * 0.045,
                ),
              ),
            ),
           ],
         ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VisitEntry(visit: visit)),
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