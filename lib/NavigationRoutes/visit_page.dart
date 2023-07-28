import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../APIs/WydAPI/Models/visit_model.dart';
import '../APIs/WydAPI/api_cache_helper.dart';
import '../Activities/visit_entry.dart';
import '../Components/my_text.dart';
import '../Components/wyd_resources.dart';
import '../language_constants.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';

class VisitPage extends StatefulWidget {
  const VisitPage({Key? key}) : super(key: key);

  @override
  State<VisitPage> createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> with TickerProviderStateMixin {
  late List<Visit>? _visitModel = null;
  late List<Visit>? lisboaList = null;
  late List<Visit>? cascaisList = null;
  late List<Visit>? setubalList = null;

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
    _visitModel = (await ApiCacheHelper.getVisits());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
      lisboaList = _visitModel?.where((i) => i.city == 'lisboa').toList();
      cascaisList = _visitModel?.where((i) => i.city == 'cascais').toList();
      setubalList = _visitModel?.where((i) => i.city == 'setúbal').toList();
    }));
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: WydColors.yellow,
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
                      color: WydColors.yellow,
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
                      margin: EdgeInsets.symmetric(horizontal: 30, vertical:20),
                      child: MyText(
                        translation(context).visitParagraph,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02),
                        ),
                      ),
                    ),
                    _visitModel != null
                    ? getVisitsTab(_tabController)
                    : Center(
                      child: Container(
                        margin: EdgeInsets.only(top: screenSize.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              translation(context).loading + '...',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: WydColors.green,
                                fontSize: 20
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: CircularProgressIndicator( //Adds a Loading Indicator
                                color: WydColors.yellow,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Column getVisitsTab(TabController _tabController) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: screenSize.width * 0.03),
          child: TabBar(
            labelColor: WydColors.green,
            indicatorColor: WydColors.yellow,
            dividerColor: Colors.grey[200],
            unselectedLabelColor: Colors.black,
            controller: _tabController,
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: MyText(
                  "Lisboa", 
                  style: TextStyle(
                    fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: MyText(
                  "Cascais", 
                  style: TextStyle(
                    fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: MyText(
                  "Setúbal", 
                  style: TextStyle(
                    fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02)
                  ),
                ),
              ),
            ],
          ),
        ),
        AutoScaleTabBarView(
          controller: _tabController,
          children: [
            getVisitsByLocation(lisboaList),
            getVisitsByLocation(cascaisList),
            getVisitsByLocation(setubalList),
          ],
        ),
      ],
    );
  }

  Column getVisitsByLocation(List<Visit>? list) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          spacing: 25.0,
          children: [
            if(_visitModel != null)...
            {
              for(Visit visit in list!)...
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