import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SymDay extends StatelessWidget {
  const SymDay({Key? key}) : super(key: key);

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
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.1),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing:8.0,
              children: [
                getGridButton(screenSize),
                getGridButton(screenSize),
                getGridButton(screenSize),
                getGridButton(screenSize),
              ],
            ),
          ),
        )
      ],
    );
  }

  Container getGridButton(Size screenSize) {
    return Container(
      margin: EdgeInsets.only(top:15),
      height: 100,
      width: 130,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
/*             if (states.contains(MaterialState.pressed))
              return Color.fromARGB(255, 18, 18, 18); */
            return Color.fromARGB(255, 237, 191, 70);
          }),
        ),
        onPressed: () {}, 
        child: Container(
          width: screenSize.width * 0.5,
          alignment: Alignment.center,
          child: Text(
          "Mapa",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: screenSize.height * 0.02,
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
            AppLocalizations.of(context)!.symDay.toUpperCase(),
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