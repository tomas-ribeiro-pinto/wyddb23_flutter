import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:wyddb23_flutter/APIs/WydAPI/Models/notification_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_constants.dart';
import 'package:wyddb23_flutter/Activities/Information/information_activity.dart';
import 'package:wyddb23_flutter/Activities/Prayers/prayers_activity.dart';
import 'package:wyddb23_flutter/Activities/Welcome/welcome_activity.dart';
import 'package:wyddb23_flutter/Activities/contacts_activity.dart';
import 'package:wyddb23_flutter/Components/notification_modal.dart';
import 'package:wyddb23_flutter/Stories/story.dart';
import 'package:wyddb23_flutter/Stories/video.dart';
import 'package:wyddb23_flutter/main.dart';
import 'package:wyddb23_flutter/APIs/WeatherAPI/weather_model.dart';
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:wyddb23_flutter/Notifications/notification.dart' as notification;

import '../APIs/WydAPI/Models/story_model.dart';
import '../APIs/WydAPI/api_cache_helper.dart';
import '../APIs/WydAPI/api_response_box.dart';
import '../APIs/WydAPI/api_service.dart';
import '../APIs/WydAPI/notification_response_box.dart';
import '../Activities/Fatima/fatima_activity.dart';
import '../Activities/faq_activity.dart';
import '../Components/follow_us_pop_up.dart';
import '../Components/my_text.dart';
import '../Components/wyd_resources.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  late Weather? _weatherModel = null;
  late List<Story>? _storyModel = null;
  late String? image = null;
  late List<SentNotification> notifications;

  @override
  void initState() {
    super.initState();
    _getData();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  void _getData() async {
    _weatherModel = await ApiCacheHelper.getWeather();
    _storyModel = (await WydApiService().getStories());
    image = (await ApiCacheHelper.getHomePic());
    notifications = await ApiCacheHelper.getNotifications();
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
      if(_storyModel != null)
      {
        if(_storyModel!.isEmpty)
        {
          _storyModel = null;
        }
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    
    Size screenSize = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Set Status Bar Text Color
      value: SystemUiOverlayStyle.light,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: screenSize.width,
                  child: const Image(
                    image: AssetImage("assets/images/wyd-home-green.jpg"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenSize.height > 850 ? screenSize.height * 0.06 :  screenSize.height * 0.05,
                                          left: screenSize.width * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _storyModel != null
                      ? Column(
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
                          IconButton(
                            onPressed: () async => {
                                NotificationModal().showModal(context, notifications)
                            }, 
                            icon: Container(
                              padding: EdgeInsets.all(screenSize.width * 0.018),
                              decoration: BoxDecoration(
                                  color: WydColors.yellow,
                                  borderRadius: BorderRadius.circular(15)),
                              child: HeroIcon(
                                HeroIcons.bellAlert,
                                color: Colors.black,
                              ),
                            )
                          )
                        ],
                      )
                    : 
                      Row(
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
                          IconButton(
                            onPressed: () async => {
                                NotificationModal().showModal(context, notifications)
                            }, 
                            icon: Container(
                              padding: EdgeInsets.all(screenSize.width * 0.018),
                              decoration: BoxDecoration(
                                  color: WydColors.yellow,
                                  borderRadius: BorderRadius.circular(15)),
                              child: HeroIcon(
                                HeroIcons.bellAlert,
                                color: Colors.black,
                              ),
                            )
                          )
                        ],
                      ),
                      if(_storyModel != null)...
                      {
                        StoryBar(storyModel: _storyModel,)
                      }
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
                                              "#WYDDONBOSCO23",
                                              style: TextStyle(
                                                fontFamily: "Barlow",
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.024, screenSize.height * 0.02, screenSize.height * 0.019),
                                                backgroundColor: Colors.black.withOpacity(0.7),
                                                letterSpacing: -1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screenSize.width * 0.7,
                                      height: screenSize.width * 0.46,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: screenSize.width * 0.15,
                                            decoration: BoxDecoration(
                                               boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 10
                                                )
                                              ] 
                                            ),
                                            child: Image(
                                              filterQuality: FilterQuality.medium,
                                              image: AssetImage("assets/images/jmj.png"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                                : Container(
                                  color: WydColors.red,
                                  child: const Center(
                                    child: SizedBox(
                                      height: 40,
                                      child: CircularProgressIndicator( //Adds a Loading Indicator
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
                  padding: _storyModel != null
                            ? EdgeInsets.only(top: screenSize.height * 0.14)
                            : EdgeInsets.only(top: screenSize.height * 0.13),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          translation(context).helloLisbon,
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
                        padding: _storyModel != null
                                ? EdgeInsets.only(top: screenSize.height * 0.205)
                                : EdgeInsets.only(top: screenSize.height * 0.195),
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
                              margin: const EdgeInsets.only(left:5),
                              height: screenSize.width * 0.06,
                              width: screenSize.width * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.white
                              ),
                              child: _weatherModel == null
                              ? const Image(
                                image: AssetImage("assets/images/weather-sun.png"),
                              )
                              :
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: CachedNetworkImage(imageUrl: ("https:${_weatherModel!.current.condition.icon}")),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left:5),
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
                                "${_weatherModel!.current.tempC.toStringAsFixed(0)}ºC",
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
              height: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.12, screenSize.height * 0.1, screenSize.height * 0.1),
            )
          ],
        ),
      ),
    );
  }

  Container getHighlightButtons(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double marginTop = 0;
    double heightIcon = screenSize.height * 0.11;
    
    marginTop = WydResources.getResponsiveValue(screenSize, screenSize.width * 0.025, screenSize.width * 0.04, screenSize.width * 0.05);
    heightIcon = WydResources.getResponsiveValue(screenSize, screenSize.height * 0.11, screenSize.height * 0.12, screenSize.height * 0.13);

    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WelcomeActivity()),
                      );
                    },
                    enableFeedback: false,
                    icon: Image.asset(
                      'assets/images/highlight-lisbon.png',
                      fit: BoxFit.fill,
                      height: heightIcon
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InformationActivity()),
                      );
                    },
                    enableFeedback: false,
                    icon: Image.asset(
                      'assets/images/highlight-world.png',
                      fit: BoxFit.fill,
                      height: heightIcon
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrayersActivity()),
                      );
                    },
                    enableFeedback: false,
                    icon: Image.asset(
                      'assets/images/highlight-cross.png',
                      fit: BoxFit.fill,
                      height: heightIcon
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
    return PopupMenuButton(
      elevation: 50,
      color: const Color.fromARGB(255, 35, 35, 35),
      onSelected: (String? newValue) async{
          Locale locale = await setLocale(newValue.toString());
          setState(() {
            MyApp.setLocale(context, locale);
          });
      },
      itemBuilder: (BuildContext bc) {
        return const [
          PopupMenuItem(
            value: "en",
            child: MyText("EN 🇬🇧", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,))
          ),
          PopupMenuItem(
            value: "pt",
            child: MyText("PT 🇵🇹", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,))
          ),
          PopupMenuItem(
            value: "es",
            child: MyText("ES 🇪🇸", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,))
          ),
          PopupMenuItem(
            value: "it",
            child: MyText("IT 🇮🇹", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,))
          ),
        ];
      },
      icon: const Icon(Icons.language, color: Colors.white,),
    );
  }

  Widget getFooterButtons()
  {
    Size screenSize = MediaQuery.of(context).size;

    if(screenSize.height > 680)
    {
      return Container(
        width: screenSize.width * 0.7,
        margin: const EdgeInsets.only(top: 20),
        child: Center(
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 10,
            children: [
                  getFooterButton(
                    screenSize, 
                    translation(context).contacts,
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContactsActivity()),
                      )
                    }),
                  getFooterButton(screenSize,
                    translation(context).fatima,
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FatimaActivity()),
                      )
                    }),
                  getFooterButton(screenSize,
                    translation(context).faq,
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FaqActivity()),
                      )
                    }),
                  getFooterButton(screenSize,
                    translation(context).followUs,
                    () => {
                      FollowUsPopUp().showSocialDialog(context)
                    }),
                ],
          ),
        ),
      );
    }
    else
    {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 5,
            children: [
                  getFooterButton(
                    screenSize, 
                    translation(context).contacts,
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContactsActivity()),
                      )
                    }),
                  getFooterButton(screenSize,
                    translation(context).fatima,
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FatimaActivity()),
                      )
                    }),
                  getFooterButton(screenSize,
                    translation(context).faq,
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FaqActivity()),
                      )
                    }),
                  getFooterButton(screenSize,
                    translation(context).followUs,
                    () => {
                      FollowUsPopUp().showSocialDialog(context)
                    }),
                ],
          ),
        ),
      );
    }
  }

  TextButton getFooterButton(Size screenSize, String content, Function()? onPressed) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 15)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.green;
          }
          return WydColors.green;
        }),
      ),
      onPressed: onPressed, 
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
    );
  }

}
