import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../Activities/accommodation_location.dart';
import '../Components/my_text.dart';
import '../language_constants.dart';
import 'package:flutter/services.dart';

class AccommodationPage extends StatelessWidget {
  const AccommodationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color:Color(0xFF028744),
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
                      color: Color(0xFF028744),
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                        child: MyText(
                          translation(context).accommodation.toUpperCase(),
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
                      margin: EdgeInsets.all(20),
                      child: MyText(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: screenSize.height * 0.02,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          getAccommodationButton(screenSize, "Cascais", context),
                          getAccommodationButton(screenSize, "Estoril", context),
                          getAccommodationButton(screenSize, "Lisboa", context),
                          getAccommodationButton(screenSize, "Manique", context),
                          getAccommodationButton(screenSize, "Setúbal", context),
                        ],
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

  Container getAccommodationButton(Size screenSize, String location, BuildContext context) {
    return Container(
            margin: EdgeInsets.only(top:15),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
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
                  MaterialPageRoute(builder: (context) => AccommodationLocation(location: location)),
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