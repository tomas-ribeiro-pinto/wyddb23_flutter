import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';
import 'package:wyddb23_flutter/NavigationRoutes/home_page.dart';
import 'package:wyddb23_flutter/NavigationRoutes/accommodation_page.dart';
import 'package:wyddb23_flutter/NavigationRoutes/visit_page.dart';
import 'package:wyddb23_flutter/NavigationRoutes/sym_day_page.dart';
import 'package:wyddb23_flutter/NavigationRoutes/agenda_page.dart';
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
      alignment: Alignment.bottomCenter,
      height: WydResources.getResponsiveSmValue(screenSize, screenSize.width * 0.2, 110, 110, 110),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(                
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.0)]
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left:0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: WydColors.green,
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
                  height: screenSize.width * 0.16, // 65
                  child: Container(
                    decoration: BoxDecoration(
                      color: WydColors.green,
                      borderRadius: const BorderRadius.only(
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
                            icon: Icon(
                                    Icons.hotel,
                                    color: Colors.white,
                                    size: screenSize.width * 0.09,
                                  ),
                          ),
                          IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              setState(() {
                                Navigator.pushNamed(context, '/visit');
                              });
                            },
                            icon: HeroIcon(
                                    HeroIcons.map,
                                    color: Colors.white,
                                    size: screenSize.width * 0.09,
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
                                height: screenSize.width * 0.15, // 70
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
                                width: 35
                              )
                          ),
                          IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              setState(() {
                                Navigator.pushNamed(context, '/agenda');
                              });
                            },
                            icon: HeroIcon(
                                    HeroIcons.calendarDays,
                                    color: Colors.white,
                                    size: screenSize.width * 0.09,
                                  )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
