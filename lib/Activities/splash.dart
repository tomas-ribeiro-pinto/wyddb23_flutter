import 'package:flutter/material.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_service.dart';
import 'package:wyddb23_flutter/Activities/home_activity.dart';
import '../APIs/WydAPI/Models/cache_eraser_model.dart';
import '../APIs/WydAPI/api_cache_eraser.dart';
import '../APIs/WydAPI/api_cache_helper.dart';
import '../Components/wyd_resources.dart';
import '../language_constants.dart';

class Splash extends StatefulWidget {
  Splash({Key? key, required}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  late String currentLanguageCode;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      // Check if there's a need to clear cache from the API
      getCacheEraserInfo();
      // Get API responses to pre-load them
      getApiResponse();
    });
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeActivity(pageIndex: 0,)));
    });
    getLocaleInfo();
  }

  Future<void> getLocaleInfo()
  async {
    currentLanguageCode = (await getLocale()).languageCode;
  }

  void getCacheEraserInfo()
  async {
    CacheEraser eraser = await ApiCacheEraser.getCacheEraserInfo();
    ApiCacheEraser.checkCacheEraserInfo(eraser);
  }


  // Seed Hive with current API response if empty
  // while loading the app
  void getApiResponse() async
  {
    await ApiCacheHelper.getAgenda();
    await ApiCacheHelper.getWeather();
    await ApiCacheHelper.getHomePic();
    await ApiCacheHelper.getVisits();
    await ApiCacheHelper.getFaq();
    await ApiCacheHelper.getInformation();

    // SYM Day
    await ApiCacheHelper.getGuides();
    await ApiCacheHelper.getTimetable();
    await ApiCacheHelper.getMap(currentLanguageCode);

    // Fatima
    await ApiCacheHelper.getFatimaGuides();
    await ApiCacheHelper.getFatimaVisits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WydColors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'assets/images/wyd-logo-cor.png',
                    height: 130,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator( //Adds a Loading Indicator
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}