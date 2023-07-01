import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../language_constants.dart';

class VisitPage extends StatelessWidget {
  const VisitPage({Key? key}) : super(key: key);

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
                        child: Text(
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
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: screenSize.height * 0.02,
                        ),
                      ),
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