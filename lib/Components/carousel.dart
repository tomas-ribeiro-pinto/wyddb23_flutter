import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wyddb23_flutter/Activities/Welcome/welcome_rector.dart';
import 'package:wyddb23_flutter/Activities/Welcome/welcome_wyd.dart';
import 'package:wyddb23_flutter/language_constants.dart';

import '../Activities/Welcome/welcome_mother.dart';

class WelcomeCarousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomeCarouselState();
  }
}

class _WelcomeCarouselState extends State<WelcomeCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {

    final List<String> imgList = [
      'assets/images/reitor-mor.jpg',
      'assets/images/madre-geral.jpg',
      'assets/images/wyd-welcome.png'
    ];

    final List<String> descriptions = [
      translation(context).rectorMessage,
      translation(context).motherMessage,
      translation(context).wydMessage,
    ];

    Size screenSize = MediaQuery.of(context).size;

    List<Widget> imageSliders = imgList
    .map((item) => getImage(screenSize, item, descriptions, imgList))
    .toList();

    return Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: screenSize.width * 0.025,
                height: screenSize.width * 0.025,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]
    );
  }

  Container getImage(Size screenSize, String item, List<String> descriptions, List<String> imgList) {
    return Container(
        child: GestureDetector(
          child: Container(
            height: screenSize.width,
            width: screenSize.width,
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        height: screenSize.width,
                        width: screenSize.width,
                        child: Image.asset(item, fit: BoxFit.cover)
                      )
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          descriptions[imgList.indexOf(item)],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          onTap: () => {
            getMessage(item, imgList)
          },
        ),
      );
  }

  void getMessage(String item, List<String> imgList)
  {
    Map<int, dynamic> messages = {
      0: WelcomeRector(),
      1: WelcomeMother(),
      2: WelcomeWyd(),
    };

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => messages[imgList.indexOf(item)]),
    );
  }
}
