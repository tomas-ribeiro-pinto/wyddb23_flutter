import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Components/agenda_list.dart';

import '../APIs/WydAPI/day_model.dart';
import 'my_text.dart';

class AgendaTabBar extends StatefulWidget {
  const AgendaTabBar({Key? key, required this.agendaModel}) : super(key: key);

  final List<Day>? agendaModel;

  @override
  State<AgendaTabBar> createState() => _AgendaTabBarState();
}

class _AgendaTabBarState extends State<AgendaTabBar> with SingleTickerProviderStateMixin
{
  DateFormat formatter = DateFormat('dd/MM');

  @override
  Widget build(BuildContext context) {
   TabController _tabController = TabController(length: widget.agendaModel!.length, vsync: this);

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
                      color: Color(0xFF028744),
                    ),
                    unselectedLabelColor: Color(0xFF028744),
                    labelStyle: TextStyle(
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w600,
                        fontSize: screenSize.height * 0.025,
                    ),
                    tabs: <Widget>[
                      for(var i = 0; i < widget.agendaModel!.length; i++)...
                      [
                        getTabButton(screenSize, widget.agendaModel![i]),
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
                      for(var i = 0; i <  widget.agendaModel!.length; i++)...
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
                                AgendaList(selectedIndex: i, day: widget.agendaModel![i]),
                                Container(
                                  height: screenSize.width * 0.3,
                                  color: Colors.transparent,
                                ),
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

  Tab getTabButton(Size screenSize, Day day) {
    return Tab(
    child: Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xFF028744),
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
          formatter.format(day.day),
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