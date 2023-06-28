import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wyddb23_flutter/NavigationPages/home_page.dart';
import 'package:wyddb23_flutter/NavigationPages/accommodation_page.dart';
import 'package:wyddb23_flutter/NavigationPages/page2.dart';
import 'package:wyddb23_flutter/NavigationPages/sym_day.dart';
import 'package:wyddb23_flutter/NavigationPages/agenda.dart';
import 'package:heroicons/heroicons.dart';

/**
 * Navigation Bar for activities outside the home_activity
 */
class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF028744),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 10,
            blurRadius: 80,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      // Includes a SafeArea for IOS devices with notch
      child: SafeArea(
        child: SizedBox(
          height: 65,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF028744),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: OverflowBox(
              maxHeight: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      Navigator.pushNamed(context, '/accommodation');
                    },
                    icon: const Icon(
                            Icons.hotel,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/visit');
                      });
                    },
                    icon: const HeroIcon(
                            HeroIcons.mapPin,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 35),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 194, 194, 194),
                        width: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 40,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        setState(() {
                          Navigator.pushNamed(context, '/home');
                        });
                      },
                      icon: Image.asset(
                        'assets/images/wyd-logo-cor.png',
                        fit: BoxFit.fill,
                        height: 70,
                      ),
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/symDay');
                      });
                    },
                    icon: SvgPicture.asset(
                        "assets/images/sym_day.svg",
                        color: Colors.white,
                        width: 35,
                      )
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/agenda');
                      });
                    },
                    icon: const Icon(
                            Icons.assignment,
                            color: Colors.white,
                            size: 35,
                          )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
