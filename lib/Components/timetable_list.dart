
import 'package:flutter/material.dart';

import '../APIs/WydAPI/day_model.dart';

class TimetableList extends StatefulWidget {
  const TimetableList({Key? key, this.selectedIndex, this.day}) : super(key: key);

  final int? selectedIndex;
  final Day? day;

  @override
  State<TimetableList> createState() => _TimetableListState();
}

class _TimetableListState extends State<TimetableList> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.start,
        spacing: 10,
        children: [
          for(Entry entry in widget.day!.entries)...
          {
            getAgendaButton(screenSize, entry),
          }
        ],
    );
  }


  Container getAgendaButton(Size screenSize, Entry entry) {
    return Container(
      width: screenSize.width * 0.9,
      child: TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Color(0xFFd53f28);
        }),
      ),
      onPressed: () {}, 
      child: Container(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
          entry.titlePt.toUpperCase(),
          style: TextStyle(
              height: 0.8,
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
}