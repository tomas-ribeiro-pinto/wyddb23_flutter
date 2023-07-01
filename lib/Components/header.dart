import 'package:flutter/material.dart';
import '../APIs/WydAPI/day_model.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:intl/intl.dart';

import 'my_text.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.title, required this.color, 
              required this.content, required this.hasBanner}) : super(key: key);

  final String title;
  final Color color;
  final Container content;
  final bool hasBanner;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: widget.color,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              if(widget.hasBanner)...
              {
                getBanner(screenSize, context),
              },
              StickyHeader(
                header: Column(
                  children: [
                    Container(
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        color: widget.color,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                        child: MyText(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: screenSize.height * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
                content: widget.content,
              ),
            ]
          ),
        ),
      ),
    );
  }

  Container getBanner(Size screenSize, BuildContext context) {
    return Container(
        height: screenSize.height * 0.05,
        width: screenSize.width,
        decoration: BoxDecoration(
          color: widget.color,
        ),
      );
  }
}
