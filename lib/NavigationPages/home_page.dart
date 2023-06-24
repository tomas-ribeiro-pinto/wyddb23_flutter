import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wyddb23_flutter/Notifications/notification_service.dart';
import 'package:wyddb23_flutter/main.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wyddb23_flutter/APIs/WeatherAPI/api_service.dart';
import 'package:wyddb23_flutter/APIs/WeatherAPI/weather_model.dart';
import 'package:wyddb23_flutter/language_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Weather? _weatherModel = null;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    //Weather _weather = (await ApiService().getWeather())!;
    _weatherModel = (await WeatherApiService().getWeather())!;
    //_weatherModel!.add(_weather);
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
                  padding: EdgeInsets.only(top: screenSize.height * 0.05, left: screenSize.width * 0.02),
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
                    padding: EdgeInsets.only(top: screenSize.height * 0.25),
                    child: Container(
                      width: screenSize.width * 0.73,
                      child: const Image(
                        image: AssetImage("assets/images/home-pic.png"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.14),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
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
                        height: 30,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color.fromARGB(255, 216, 44, 32),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left:5),
                              height: 20,
                              width: 20,
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
                                child: Image.network("https:" + _weatherModel!.current.condition.icon.toString()),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left:5),
                              child: _weatherModel == null
                              ? Text(
                                  " -- ºC",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                )
                              : 
                              Text(
                                _weatherModel!.current.tempC.toStringAsFixed(0) + "ºC",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
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
              height: 100,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Row getHighlightButtons(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  enableFeedback: false,
                  icon: Image.asset(
                    'assets/images/highlight-lisbon.png',
                    fit: BoxFit.fill,
                    height: screenSize.height * 0.11,
                  ),
                ),
                Text(
                  translation(context).welcome,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    //NotificationService().showNotification(title: 'It works!');
                  },
                  enableFeedback: false,
                  icon: Image.asset(
                    'assets/images/highlight-world.png',
                    fit: BoxFit.fill,
                    height: screenSize.height * 0.11,
                  ),
                ),
                Text(
                  translation(context).information,
                  style: TextStyle(
                    fontSize: 15,
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
                Text(
                  translation(context).dailyPrayers,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        );
  }

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("EN", style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white,)),value: "en"),
      DropdownMenuItem(child: Text("PT", style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white,)),value: "pt"),
    ];
    return menuItems;
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
            child: Text("EN 🇬🇧", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
            value: "en"
          ),
          PopupMenuItem(
            child: Text("PT 🇵🇹", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
            value: "pt"
          ),
        ];
      },
      icon: Icon(Icons.language, color: Colors.white,),
    );
  }

  Widget getFooterButtons()
  {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top:screenSize.height * 0.04, right: screenSize.width * 0.08),
              height: screenSize.height * 0.06,
              width: screenSize.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xFF028744),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    translation(context).contacts,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: screenSize.width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:screenSize.height * 0.04, right: 0),
              height: screenSize.height * 0.06,
              width: screenSize.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xFF028744),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    translation(context).fatima,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: screenSize.width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top:screenSize.height * 0.02, right: screenSize.width * 0.08),
              height: screenSize.height * 0.06,
              width: screenSize.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xFF028744),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    translation(context).faq,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: screenSize.width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:screenSize.height * 0.02, right: 0),
              height: screenSize.height * 0.06,
              width: screenSize.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xFF028744),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    translation(context).followUs,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: screenSize.width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

}
