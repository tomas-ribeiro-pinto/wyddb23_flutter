import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Components/agenda_list.dart';
import 'package:wyddb23_flutter/Components/prayers_list.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/Models/prayer_model.dart' as prayer;

import '../APIs/WydAPI/Models/prayer_model.dart';
import 'my_text.dart';

class PrayersTabBar extends StatefulWidget {
  const PrayersTabBar({Key? key, required this.prayerModel}) : super(key: key);

  final Map<DateTime, List<Prayer>>? prayerModel;

  @override
  State<PrayersTabBar> createState() => _PrayersTabBarState();
}

class _PrayersTabBarState extends State<PrayersTabBar> with TickerProviderStateMixin
{
  DateFormat formatter = DateFormat('dd/MM');

  @override
  Widget build(BuildContext context) {
   TabController _tabController = TabController(length: widget.prayerModel!.length, vsync: this);

    Size screenSize = MediaQuery.of(context).size;

    return Column(
        children: [
          Container(
                height: 45,
                child: Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  child: TabBar(
                    controller: _tabController,
                    splashFactory: NoSplash.splashFactory,
                    labelColor: Colors.white,
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(horizontal: 5),
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: WydColors.red,
                    ),
                    unselectedLabelColor: WydColors.red,
                    labelStyle: TextStyle(
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w600,
                        fontSize: screenSize.height * 0.025,
                    ),
                    tabs: <Widget>[
                      for(var entry in widget.prayerModel!.keys)...
                      [
                        getTabButton(screenSize, entry),
                      ]
                    ],
                  ),
                ),
              ),
          Expanded(
            child: Container(
              height: screenSize.height * 0.7,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: screenSize.width * 0.05),
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                      for(var key in widget.prayerModel!.keys)...
                      {
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              spacing: 10,
                              children: [
                                PrayersList(prayers: widget.prayerModel![key],),
                                Container(
                                  height: screenSize.height * 0.17,
                                )
                              ],
                            ),
                          ),
                        ),
                      },
                  ]
                ),
              ),
            ),
          ),
        ],
      );
  }

  Tab getTabButton(Size screenSize, DateTime prayer) {
    return Tab(
    child: Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: WydColors.red,
              width: 3,
              style: BorderStyle.solid
          ), 
          borderRadius: BorderRadius.circular(50)
        ),
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04, vertical: 5),
          child: MyText(
          formatter.format(prayer),
          style: TextStyle(
              fontFamily: "Rubik",
              fontWeight: FontWeight.w600,
              fontSize: screenSize.height * 0.025,
            )
          ),
        ),
      ),
    ),
  );
  }
}