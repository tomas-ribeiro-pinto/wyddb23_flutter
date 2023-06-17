import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wyddb23_flutter/main.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wyddb23_flutter/WeatherAPI/api_service.dart';
import 'package:wyddb23_flutter/WeatherAPI/weather_model.dart';

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
    _weatherModel = (await ApiService().getWeather())!;
    //_weatherModel!.add(_weather);
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Set Status Bar Text Color
      value: SystemUiOverlayStyle.light,
      child: Column(
        children: [
          Stack(
            children: [
              const Image(
                image: AssetImage("assets/images/wyd-home-green.jpg"),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 160),
                  child: const Image(
                    image: AssetImage("assets/images/home-pic.png"),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 45, right: 12),
                child: Transform.scale(
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
              ),
              Container(
                margin: const EdgeInsets.only(top: 90),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.helloLisbon,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 33,
                        ),
                      )
                    ]),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                    margin: EdgeInsets.only(top:140),
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
                            padding: const EdgeInsets.all(2.0),
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
                ]),
            ],
          ),
          Row(
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
                      height: 80,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.agenda,
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
                      'assets/images/highlight-world.png',
                      fit: BoxFit.fill,
                      height: 80,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.map,
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
                      height: 80,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.hymn,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 8),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: const Color.fromARGB(255, 216, 44, 32),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            "🙏",
                            style: TextStyle(
                              fontSize: 35,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.symDay,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color.fromARGB(255, 25, 20, 20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            "📝",
                            style: TextStyle(
                              fontSize: 35,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.notes,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color.fromARGB(115, 13, 13, 13),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color.fromARGB(115, 13, 13, 13),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color.fromARGB(115, 13, 13, 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.transparent,
          ),
        ],
      ),
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

  Widget getLanguageDropdown()
  {
     return DropdownButtonFormField(
        //icon: Icon(Icons.arrow_downward_outlined),
        icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color:Color.fromARGB(255, 194, 194, 194), width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color:Color.fromARGB(255, 194, 194, 194), width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 35, 35, 35),
        ),
        dropdownColor: Color.fromARGB(255, 35, 35, 35),
        value: "en",
        onChanged: (String? newValue) {
          setState(() {
            String locale = newValue.toString();
            MyApp.setLocale(context, Locale(locale));
          });
        },
        items: dropdownItems);
  }

  Widget getLanguagePopUp()
  {
    return PopupMenuButton(
      elevation: 50,
      color: Color.fromARGB(255, 35, 35, 35),
      onSelected: (String? newValue) {
          setState(() {
            String locale = newValue.toString();
            MyApp.setLocale(context, Locale(locale));
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
}
