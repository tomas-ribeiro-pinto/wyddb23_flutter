import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
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

  @override
  void initState() {
    super.initState();
    _selectDay(selectedIndex);
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
                              translation(context)!.agenda.toUpperCase(),
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
                              for(var i = 0 ; i < 4; i++)...[
                                getHorizontalButton(screenSize, i)
                              ]
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
                  child: TimetableList(selectedIndex: selectedIndex)
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

  Container getHorizontalButton(Size screenSize, int id) {
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
          "01/08",
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

Container getActiveHorizontalButton(Size screenSize) {
    return Container(
      child: TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF028744)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(
            color: Color(0xFF028744),
            width: 3,
            style: BorderStyle.solid
          ), borderRadius: BorderRadius.circular(50)),
        )
      ),
      onPressed: () {}, 
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Text(
          "01/08",
          style: TextStyle(
              height: 0.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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