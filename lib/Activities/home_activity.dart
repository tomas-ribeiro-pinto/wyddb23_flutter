import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wyddb23_flutter/NavigationPages/home_page.dart';
import 'package:wyddb23_flutter/NavigationPages/accommodation_page.dart';
import 'package:wyddb23_flutter/NavigationPages/page2.dart';
import 'package:wyddb23_flutter/NavigationPages/sym_day.dart';
import 'package:wyddb23_flutter/NavigationPages/agenda.dart';
import 'package:heroicons/heroicons.dart';


class HomeActivity extends StatefulWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {

  static const HOMEPAGE_index = 0;
  static const PAGE1_index = 1;
  static const PAGE2_index = 2;
  static const PAGE3_index = 3;
  static const PAGE4_index = 4;

  //set HomePage to be current page
  int pageIndex = HOMEPAGE_index;

  final pages = [
    const HomePage(),
    const AccommodationPage(),
    const Page2(),
    const SymDay(),
    const Agenda(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[pageIndex],
      backgroundColor: Colors.white,
    
      // set the bottom navigation bar
      bottomNavigationBar: getNavigationBar(),
    );
  }

  /// Returns the navigation bar design widget
  Container getNavigationBar() {
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
                      setState(() {
                        pageIndex = PAGE1_index;
                      });
                    },
                    icon: pageIndex == PAGE1_index
                        ? const Icon(
                            Icons.hotel,
                            color: Color.fromARGB(255, 246, 190, 24),
                            size: 35,
                          )
                        : const Icon(
                            Icons.hotel,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = PAGE2_index;
                      });
                    },
                    icon: pageIndex == PAGE2_index
                        ? const HeroIcon(
                            HeroIcons.map,
                            color: Color.fromARGB(255, 246, 190, 24),
                            size: 35,
                            style: HeroIconStyle.solid
                          )
                        : const HeroIcon(
                            HeroIcons.map,
                            color: Colors.white,
                            size: 35,
                            style: HeroIconStyle.solid
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
                          pageIndex = HOMEPAGE_index;
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
                        pageIndex = PAGE3_index;
                      });
                    },
                    icon: pageIndex == PAGE3_index
                    ? SvgPicture.asset(
                        "assets/images/sym_day.svg",
                        color: Color.fromARGB(255, 246, 190, 24),
                        width: 35,
                      )
                    : SvgPicture.asset(
                        "assets/images/sym_day.svg",
                        color: Colors.white,
                        width: 35,
                      )
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = PAGE4_index;
                      });
                    },
                    icon: pageIndex == PAGE4_index
                        ? const Icon(
                            Icons.assignment,
                            color: Color.fromARGB(255, 246, 190, 24),
                            size: 35,
                          )
                        : const Icon(
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