import 'package:flutter/material.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sticky_headers/sticky_headers.dart';


class SymDay extends StatelessWidget {
  const SymDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: Color(0xFF028744),
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
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        color: Color(0xFF028744),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                        child: Text(
                          AppLocalizations.of(context)!.symDay.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: screenSize.height * 0.04,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02, vertical: 18),
                      child: Container(
                        alignment: Alignment.topRight,
                          child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Color(0xFFd53f28);
                            }),
                          ),
                          onPressed: () {}, 
                          child: Container(
                            width: screenSize.width * 0.5,
                            alignment: Alignment.center,
                            child: Text(
                            AppLocalizations.of(context)!.seeMap.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: screenSize.height * 0.02,
                              ),
                            ),
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
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: screenSize.height * 0.02,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 25.0,
                    children: [
                      getGridButton(screenSize, AppLocalizations.of(context)!.map),
                      getGridButton(screenSize, AppLocalizations.of(context)!.timetable),
                      getGridButton(screenSize, AppLocalizations.of(context)!.guides),
                      getGridButton(screenSize, AppLocalizations.of(context)!.symForum),
                      getGridButton(screenSize, AppLocalizations.of(context)!.liveStreaming),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                      getGridButton(screenSize, AppLocalizations.of(context)!.emergency),
                    ],
                  ),
                              ),
                              Container(
                  height: 100,
                  color: Colors.transparent,
                              ),
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
      height: 120,
      width: 145,
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
            return Color.fromARGB(255, 237, 191, 70);
          }),
        ),
        onPressed: () {}, 
        child: Stack(
          children: [
            Container(
              width: screenSize.width * 0.5,
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.bottomLeft,
              child: Text(
              string.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 17,
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
          color: Color(0xFF028744),
        ),
      );
  }
}