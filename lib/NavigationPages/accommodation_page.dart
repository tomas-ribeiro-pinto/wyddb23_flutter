import 'package:flutter/material.dart';
import '../Activities/accommodation_location.dart';
import '../language_constants.dart';
import 'package:flutter/services.dart';

class AccommodationPage extends StatelessWidget {
  const AccommodationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        getBanner(screenSize, context),
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
        )
      ],
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
                child: Text(
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
        height: screenSize.height * 0.2,
        width: screenSize.width,
        decoration: BoxDecoration(
          color: Color(0xFF028744),
        ),
        child: Container(
          margin: EdgeInsets.only(top: screenSize.height * 0.12, left: screenSize.width * 0.05),
          child: Text(
            translation(context).accommodation.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: screenSize.height * 0.04,
            ),
          ),
        ),
      );
  }
}