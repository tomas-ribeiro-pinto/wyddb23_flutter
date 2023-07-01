
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Activities/agenda_entry.dart';

import '../APIs/WydAPI/day_model.dart';
import '../language_constants.dart';
import 'my_text.dart';

class AgendaList extends StatefulWidget {
  const AgendaList({Key? key, this.selectedIndex, this.day}) : super(key: key);

  final int? selectedIndex;
  final Day? day;

  @override
  State<AgendaList> createState() => _AgendaListState();
}

class _AgendaListState extends State<AgendaList> {

  DateFormat formatter = DateFormat('HH:mm');
  
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<Entry> entries = widget.day!.entries;
    entries.sort((a, b) => a.startTime.compareTo(b.startTime));

    return Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.start,
        spacing: 10,
        children: [
          if(!entries.isEmpty)...
          {
            for(Entry entry in entries)...
            {
              getAgendaButton(screenSize, entry),
            }
          }
          else...
          {
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: HeroIcon(HeroIcons.noSymbol)
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: MyText(
                      translation(context).noRecords,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF028744),
                        fontSize: screenSize.width * 0.05
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AgendaEntry(entry: entry)),
        );
      }, 
      child: Container(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              MyText(
              formatter.format(entry.startTime),
              style: TextStyle(
                  height: 0.8,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFf6be18),
                  fontSize: screenSize.height * 0.02,
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal:5),
                  child: MyText(
                  entry.getTranslatedTitleAttribute(currentLanguageCode).toUpperCase(),
                  style: TextStyle(
                      height: 0.8,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: screenSize.height * 0.023,
                    ),
                  ),
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