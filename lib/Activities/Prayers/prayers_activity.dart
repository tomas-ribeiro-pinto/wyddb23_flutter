import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/prayer_model.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_cache_helper.dart';
import 'package:wyddb23_flutter/Components/agenda_tab_bar.dart';
import 'package:wyddb23_flutter/Components/check_connection.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/prayer_model.dart' as prayer;
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/Components/prayers_tab_bar.dart';

import '../../APIs/WydAPI/Models/agenda_model.dart';
import '../../Components/header.dart';
import '../../Components/my_text.dart';
import '../../Components/wyd_resources.dart';
import '../../language_constants.dart';

class PrayersActivity extends StatefulWidget {
  const PrayersActivity({Key? key}) : super(key: key);

  @override
  State<PrayersActivity> createState() => _PrayersActivityState();
}

class _PrayersActivityState extends State<PrayersActivity> {

  late List<List<Prayer>>? _prayerModel = null;
  late List<DateTime> days = [];
  late Map<DateTime, List<Prayer>> prayers = new Map();

  @override
  void initState() {
    super.initState();
    _getPrayers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getPrayers() async {
    _prayerModel = (await ApiCacheHelper.getPrayers());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
      groupModel();
    }));
  }

  void groupModel() async {
    if(_prayerModel != null)
    {
      for(var element in _prayerModel!)
      {
        if(!days.contains(element[0].day.day))
        {
          days.add(element[0].day.day);
        }
      }
      for(var day in days!)
      {
        List<Prayer> emptyList = [];
        prayers[day] = emptyList;
        for(var element in _prayerModel!)
        {
          if(prayers[element[0].day.day] != null)
          {
            if(!prayers[element[0].day.day]!.contains(element[0]) && element[0].orderIndex != null)
            {
              prayers[element[0].day.day]!.add(element[0]);
            }
          }
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
        transform:  Matrix4.translationValues(-20.0, 0.0, 0.0),
          child: TextButton.icon(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          label: MyText(
            translation(context).home.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: WydColors.yellow,
              fontSize: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        ),
        backgroundColor: WydColors.green,
        surfaceTintColor: WydColors.green,
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: translation(context).dailyPrayers,
        titleColor: Colors.white,
        color: WydColors.green,
        content: getEntryContent(),
        hasBanner: false,
      ),
    );
  }
                      
  Container getEntryContent()
  {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height,
      color: Colors.white,
      child: Container(
        height: screenSize.height *0.35,
        child: 
          days.isNotEmpty
        ? Container(
            child:Container(
              margin: EdgeInsets.only(top: screenSize.height * 0.025),
              child: PrayersTabBar(
                prayerModel: prayers
              ),
            ),
          )
        :
          Center(
            child: Container(
              margin: EdgeInsets.only(top: screenSize.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyText(
                    translation(context).loading + '...',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: WydColors.green,
                      fontSize: 20
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator( //Adds a Loading Indicator
                      color: WydColors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

class PrayerDay{
  prayer.Day day;
  List<Prayer> prayers;

  PrayerDay({
    required this.day,
    required this.prayers
  });
}