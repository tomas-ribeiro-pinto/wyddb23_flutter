import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../APIs/WydAPI/api_service.dart';
import '../APIs/WydAPI/day_model.dart';
import '../language_constants.dart';
import 'package:wyddb23_flutter/Components/timetable_list.dart';

class Agenda extends StatefulWidget {
  const Agenda({Key? key}) : super(key: key);

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {

  // Current Day selected initialised to first day
  int selectedIndex = 0;

  late List<Day>? _timetableModel = null;
  DateFormat formatter = DateFormat('dd/MM');

  @override
  void initState() {
    super.initState();
    _getTimetable();
    _selectDay(selectedIndex);
  }

  void _getTimetable() async {
    _timetableModel = (await WydApiService().getTimetable());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  void _selectDay(int selectedIndex) {
    this.selectedIndex = selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: Color(0xFFd53f28),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              getBanner(screenSize, context),
              StickyHeader(
                header: Column(
                  children: [
                    Container(
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFd53f28),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                            child: Text(
                              translation(context).agenda.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: screenSize.height * 0.04,
                              ),
                            ),
                          ),
                        ),
                    Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      height: screenSize.height * 0.1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            children: [
                              if(_timetableModel != null)...
                              {
                                for(var i = 0; i < _timetableModel!.length; i++)...
                                [
                                  getHorizontalButton(screenSize, i, _timetableModel![i])
                                ]
                              }
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                  content: Container(
                  color: Colors.white,
                  child: Column(
                  children: [
                  SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _timetableModel != null ? TimetableList(selectedIndex: selectedIndex, day: _timetableModel![selectedIndex]) : null
                  ),
                  Container(
                    height: 150,
                    color: Colors.transparent,
                    ),
                    ],
                  ),
                )
              ),
            ],
          )
        ),
      ),
    );
  }

  Container getHorizontalButton(Size screenSize, int id, Day day) {
    return Container(
      child: TextButton(
      style: ButtonStyle(
        backgroundColor: id == this.selectedIndex 
                        ? MaterialStateProperty.all<Color>(Color(0xFF028744))
                        : MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(
            color: Color(0xFF028744),
            width: 3,
            style: BorderStyle.solid
          ), borderRadius: BorderRadius.circular(50)),
        )
      ),
      onPressed: () {
        setState(() {
          _selectDay(id);
        });
      }, 
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Text(
          formatter.format(day.day),
          style: id == this.selectedIndex 
            ?
            TextStyle(
              height: 0.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: screenSize.height * 0.025,
            )
            :
            TextStyle(
              height: 0.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF028744),
              fontSize: screenSize.height * 0.025,
            ),
          ),
        ),
      ),
    ),
  );
}

  Container getBanner(Size screenSize, BuildContext context) {
    return Container(
        height: screenSize.height * 0.05,
        width: screenSize.width,
        decoration: BoxDecoration(
          color: Color(0xFFd53f28),
        ),
      );
  }
}