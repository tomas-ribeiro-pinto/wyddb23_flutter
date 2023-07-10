import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:wyddb23_flutter/APIs/WydAPI/api_constants.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_service.dart' as wyd;
import 'package:wyddb23_flutter/Activities/Information/information_activity.dart';
import 'package:wyddb23_flutter/Activities/Welcome/welcome_activity.dart';
import 'package:wyddb23_flutter/Notifications/notification_service.dart';
import 'package:wyddb23_flutter/main.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wyddb23_flutter/APIs/WeatherAPI/api_service.dart';
import 'package:wyddb23_flutter/APIs/WeatherAPI/weather_model.dart';
import 'package:wyddb23_flutter/language_constants.dart';

import '../APIs/WydAPI/api_cache_helper.dart';
import '../Components/my_text.dart';
import '../Components/wyd_resources.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  late Weather? _weatherModel = null;
  late String? image = null;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _weatherModel = await ApiCacheHelper.getWeather();
    image = (await ApiCacheHelper.getHomePic());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    
    Size screenSize = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Set Status Bar Text Color
      value: SystemUiOverlayStyle.light,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: screenSize.width,
                  child: const Image(
                    image: AssetImage("assets/images/wyd-home-green.jpg"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenSize.height > 850 ? screenSize.height * 0.06 :  screenSize.height * 0.05,
                                          left: screenSize.width * 0.02),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 194, 194, 194),
                                width: 1,
                              ),
                              color: Color.fromARGB(255, 35, 35, 35),
                              borderRadius: BorderRadius.circular(15)),
                          child: getLanguagePopUp()
                        ),
                      ),
                      Container(
                        width: screenSize.width * 0.8,
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: screenSize.width * 0.05),
                                height: screenSize.width * 0.15,
                                width: screenSize.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(screenSize.width * 0.2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: screenSize.width * 0.05),
                                height: screenSize.width * 0.15,
                                width: screenSize.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(screenSize.width * 0.2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: screenSize.width * 0.05),
                                height: screenSize.width * 0.15,
                                width: screenSize.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(screenSize.width * 0.2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: screenSize.width * 0.05),
                                height: screenSize.width * 0.15,
                                width: screenSize.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(screenSize.width * 0.2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: screenSize.width * 0.05),
                                height: screenSize.width * 0.15,
                                width: screenSize.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(screenSize.width * 0.2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: screenSize.width * 0.05),
                                height: screenSize.width * 0.15,
                                width: screenSize.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(screenSize.width * 0.2),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: screenSize.width * 0.05),
                                height: screenSize.width * 0.15,
                                width: screenSize.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(screenSize.width * 0.2),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.27),
                    child: Transform.rotate(
                        angle: math.radians(7),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 10,
                                    blurRadius: 30,
                                    offset: const Offset(0, 0), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(-2, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              height: screenSize.width * 0.515,
                              width: screenSize.width * 0.73,
                              child: Padding(
                                padding: EdgeInsets.all(screenSize.width * 0.03),
                                child: image != null
                                ? Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        height: screenSize.width * 0.515,
                                        width: screenSize.width * 0.73,
                                        color: WydColors.red,
                                        child: Image(
                                          image: CachedNetworkImageProvider(ApiConstants.baseUrl + image!),
                                          fit: BoxFit.cover,
                                          frameBuilder: (BuildContext context, Widget child, int? frame,
                                              bool wasSynchronouslyLoaded) {
                                            if (wasSynchronouslyLoaded) {
                                              return child;
                                            }
                                            return AnimatedOpacity(
                                              opacity: frame == null ? 0 : 1,
                                              duration: const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                              child: child,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            MyText(
                                              "@leilacatarina",
                                              style: TextStyle(
                                                fontFamily: "Barlow",
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontSize: screenSize.height * 0.019,
                                                backgroundColor: Colors.black.withOpacity(0.7),
                                                letterSpacing: -1,
                                              ),
                                            ),
                                            MyText(
                                              "#WYDDONBOSCO23",
                                              style: TextStyle(
                                                fontFamily: "Barlow",
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: screenSize.height * 0.019,
                                                backgroundColor: Colors.black.withOpacity(0.7),
                                                letterSpacing: -1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : Container(
                                  color: WydColors.red,
                                  child: Center(
                                    child: Container(
                                      height: 40,
                                      child: const CircularProgressIndicator( //Adds a Loading Indicator
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
                Container(
                  height: screenSize.width * 0.11,
                  margin: EdgeInsets.only(top: screenSize.height * 0.25, left: screenSize.width * 0.46,),
                  child: const Image(
                    image: AssetImage("assets/images/tape.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.14),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          AppLocalizations.of(context)!.helloLisbon,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: screenSize.height * 0.04,
                          ),
                        )
                      ]),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height * 0.205),
                        child: Container(
                        height: screenSize.width * 0.08,
                        width: screenSize.width * 0.23,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color.fromARGB(255, 216, 44, 32),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left:5),
                              height: screenSize.width * 0.06,
                              width: screenSize.width * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.white
                              ),
                              child: _weatherModel == null
                              ? Image(
                                image: AssetImage("assets/images/weather-sun.png"),
                              )
                              :
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: CachedNetworkImage(imageUrl: ("https:" + _weatherModel!.current.condition.icon.toString())),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left:5),
                              child: _weatherModel == null
                              ? MyText(
                                  " -- ºC",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenSize.width * 0.042,
                                  ),
                                )
                              : 
                              MyText(
                                _weatherModel!.current.tempC.toStringAsFixed(0) + "ºC",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.width * 0.043,
                                ),
                              ),
                            ),
                          ],
                        ),
                                        ),
                      ),
                  ]),
              ],
            ),
            getHighlightButtons(context),
            getFooterButtons(),
            Container(
              height: screenSize.height * 0.1,
            )
          ],
        ),
      ),
    );
  }

  Container getHighlightButtons(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double marginTop = 0;
    
    if(screenSize.height > 650 && screenSize.height < 670)
    {
      marginTop = screenSize.width * 0.025;
    }
    else if(screenSize.height > 670 && screenSize.height < 850)
    {
      marginTop = screenSize.width * 0.04;
    }
    else if(screenSize.height > 850)
    {
      marginTop = screenSize.width * 0.05;
    }

    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomeActivity()),
                      );
                    },
                    enableFeedback: false,
                    icon: Image.asset(
                      'assets/images/highlight-lisbon.png',
                      fit: BoxFit.fill,
                      height: screenSize.height * 0.11,
                    ),
                  ),
                  MyText(
                    translation(context).welcome,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.04,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      //NotificationService().showNotification(title: 'It works!');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InformationActivity()),
                      );
                    },
                    enableFeedback: false,
                    icon: Image.asset(
                      'assets/images/highlight-world.png',
                      fit: BoxFit.fill,
                      height: screenSize.height * 0.11,
                    ),
                  ),
                  MyText(
                    translation(context).information,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.04,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    enableFeedback: false,
                    icon: Image.asset(
                      'assets/images/highlight-cross.png',
                      fit: BoxFit.fill,
                      height: screenSize.height * 0.11,
                    ),
                  ),
                  MyText(
                    translation(context).dailyPrayers,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.04,
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  Widget getLanguagePopUp()
  {
    Size screenSize = MediaQuery.of(context).size;
    return PopupMenuButton(
      elevation: 50,
      color: Color.fromARGB(255, 35, 35, 35),
      onSelected: (String? newValue) async{
          Locale locale = await setLocale(newValue.toString());
          setState(() {
            MyApp.setLocale(context, locale);
          });
      },
      itemBuilder: (BuildContext bc) {
        return const [
          PopupMenuItem(
            child: MyText("EN 🇬🇧", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
            value: "en"
          ),
          PopupMenuItem(
            child: MyText("PT 🇵🇹", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
            value: "pt"
          ),
          PopupMenuItem(
            child: MyText("ES 🇪🇸", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
            value: "es"
          ),
          PopupMenuItem(
            child: MyText("IT 🇮🇹", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
            value: "it"
          ),
        ];
      },
      icon: Icon(Icons.language, color: Colors.white,),
    );
  }

  Widget getFooterButtons()
  {
    Size screenSize = MediaQuery.of(context).size;

    if(screenSize.height > 680)
    {
      return Container(
        width: screenSize.width * 0.7,
        margin: EdgeInsets.only(top: 20),
        child: Center(
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 10,
            children: [
                  getFooterButton(screenSize, translation(context).contacts,),
                  getFooterButton(screenSize, translation(context).fatima,),
                  getFooterButton(screenSize, translation(context).faq),
                  getFooterButton(screenSize, translation(context).followUs),
                ],
          ),
        ),
      );
    }
    else
    {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 5,
            children: [
                  getFooterButton(screenSize, translation(context).contacts,),
                  getFooterButton(screenSize, translation(context).fatima,),
                  getFooterButton(screenSize, translation(context).faq),
                  getFooterButton(screenSize, translation(context).followUs),
                ],
          ),
        ),
      );
    }
  }

  Container getFooterButton(Size screenSize, String content) {
    return Container(
          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.green;
                return WydColors.green;
              }),
            ),
            onPressed: () {}, 
            child: Container(
              width: screenSize.width * 0.3,
              alignment: Alignment.center,
              child: MyText(
              content,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: screenSize.width * 0.04,
                ),
              ),
            ),
          ),
        );
  }

}
