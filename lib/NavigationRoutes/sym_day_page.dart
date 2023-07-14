import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../Activities/guide_activity.dart';
import '../Components/my_text.dart';
import '../Components/wyd_resources.dart';
import '../language_constants.dart';


class SymDayPage extends StatelessWidget {
  const SymDayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    
    return Container(
      color:WydColors.green,
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
                      color: WydColors.green,
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                        child: MyText(
                          translation(context).symDay.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
                    translation(context).symDayParagraph,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02)
                    ),
                  ),
                ),
                /* Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 25.0,
                  children: [
                    getGridButton(screenSize, translation(context).map),
                    getGridButton(screenSize, translation(context).timetable),
                    getGridButton(screenSize, translation(context).guides),
                    getGridButton(screenSize, translation(context).symForum),
                    getGridButton(screenSize, translation(context).liveStreaming),
                    getGridButton(screenSize, translation(context).emergency),
                  ],
                ), */
              Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 25.0,
                      children: [
                        getButton(screenSize, translation(context).map, context),
                        getButton(screenSize, translation(context).timetable, context),
                        getButton(screenSize, translation(context).guides, context),
                        getButton(screenSize, translation(context).symForum, context),
                        getButton(screenSize, translation(context).liveStreaming, context),
                        getButton(screenSize, translation(context).emergency, context),
                      ],
                    ),
                Container(
                  height: screenSize.height * 0.17,
                )
                  ],
                              ),
                )
              ),
            ],
          )
        ),
      ),
    );
  }

  Container getGridButton(Size screenSize, String string) {
    return Container(
      margin: EdgeInsets.only(top:20),
      height: screenSize.width * 0.27,
      width: screenSize.width * 0.4,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 10)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
/*             if (states.contains(MaterialState.pressed))
              return Color.fromARGB(255, 18, 18, 18); */
            return WydColors.yellow;
          }),
        ),
        onPressed: () {}, 
        child: Stack(
          children: [
            Container(
              width: screenSize.width * 0.5,
              margin: EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.bottomLeft,
              child: MyText(
              string.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: screenSize.width * 0.04,
                ),
              ),
            ),
            Container(
              width: screenSize.width * 0.5,
              margin: EdgeInsets.only(right: 10),
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                "assets/images/info.svg",
                width: 30,
              )
            ),
          ],
        ),
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

  Container getButton(Size screenSize, String location, BuildContext context) {
    return Container(
            margin: EdgeInsets.only(top:15),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return WydColors.green;
                }),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuideActivity()),
                );
              }, 
              child: Container(
                width: screenSize.width * 0.7,
                alignment: Alignment.center,
                child: MyText(
                location.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: screenSize.height * 0.025,
                  ),
                ),
              ),
            ),
          );
  }
}