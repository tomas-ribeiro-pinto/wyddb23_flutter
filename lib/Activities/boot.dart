import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hive/hive.dart';
import 'package:wyddb23_flutter/Activities/splash.dart';
import 'package:wyddb23_flutter/Notifications/notification_service.dart';
import 'package:wyddb23_flutter/language_constants.dart';

import '../APIs/WydAPI/api_response_box.dart';
import '../Components/wyd_resources.dart';

class Boot extends StatefulWidget{
  Boot({Key? key});

  @override
  _BootState createState() => _BootState();
}

class _BootState extends State<Boot> {

  String? currentLanguageCode;
  bool? isFirstBoot;
  ConnectivityResult? connectivityResult;

  @override
  void initState() {
    super.initState();
    getBootInfo();
  }

  getBootInfo()
  async {
    currentLanguageCode = (await getLocale()).languageCode;
    isFirstBoot = await checkFirstBoot();
    connectivityResult = await (Connectivity().checkConnectivity());

    setState(() {
      getApp();
    });
  }

  Future<bool> checkFirstBoot() async
  {
    var box = await Hive.openBox<ApiResponseBox>('apiResponses');

    return box.length == 0 ? true : false;
  }

  void getApp()
  {
    if(connectivityResult != ConnectivityResult.none && isFirstBoot!)
    {
      NotificationService.setWelcome(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Splash()));
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Splash()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WydColors.green,
    );
  }
}