import 'package:flutter/material.dart';
import 'package:wyddb23_flutter/Activities/home_activity.dart';
import '../APIs/WydAPI/api_cache_helper.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    getApiResponse();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeActivity(pageIndex: 0,)));
    });
  }

  // Seed Hive with current API response if empty
  // while loading the app
  void getApiResponse() async
  {
    await ApiCacheHelper.getAgenda();
    await ApiCacheHelper.getWeather();
    await ApiCacheHelper.getHomePic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF028744),
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