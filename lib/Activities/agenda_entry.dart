import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';

import '../APIs/WydAPI/day_model.dart';
import '../Components/my_text.dart';

class AgendaEntry extends StatefulWidget {
  const AgendaEntry({Key? key, required this.entry}) : super(key: key);

  final Entry entry;

  @override
  State<AgendaEntry> createState() => _AgendaEntryState();
}

class _AgendaEntryState extends State<AgendaEntry> {

  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  DateFormat formatter = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform:  Matrix4.translationValues(-30.0, 0.0, 0.0),
          child: GestureDetector(
            onTap: () => {Navigator.of(context).pop()},
            child: MyText(
              translation(context).agenda.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFFf6be18),
                fontSize: 20
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFFd53f28),
        surfaceTintColor: Color(0xFFd53f28),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: widget.entry!.getTranslatedTitleAttribute(currentLanguageCode).toUpperCase(),
        color: Color(0xFFd53f28),
        content: getEntryContent(),
        hasBanner: false,
      ),
    );
  }

  Container getEntryContent()
  {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20), 
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                  formatter.format(widget.entry.startTime) + ' - ' + formatter.format(widget.entry.endTime),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFf6be18),
                    fontSize: 20
                  ),
                  ),
                  Row(
                    children: [
                      HeroIcon(
                        HeroIcons.mapPin,
                        style: HeroIconStyle.solid,
                        color: Color(0xFF028744),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: MyText(
                        widget.entry.location,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),
                        ),
                      ),
                    ],
                  ),
                  getEntryDescription()
                ],
              ),
            Container(
              height: 150,
              color: Colors.transparent,
            ),
            ],
          ),
        ),
      ),
    );
  }

  Container getEntryDescription()
  {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: MyText(
          widget.entry!.getTranslatedDescriptionAttribute(currentLanguageCode),
          style: TextStyle(
            fontSize: 18
          ),
        ),
      ),
    );
  }

}