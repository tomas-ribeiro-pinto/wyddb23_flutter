import 'package:flutter/material.dart';
import 'package:wyddb23_flutter/Components/header';
import 'package:wyddb23_flutter/language_constants.dart';

import '../APIs/WydAPI/day_model.dart';

class AgendaEntry extends StatefulWidget {
  const AgendaEntry({Key? key, required this.entry}) : super(key: key);

  final Entry entry;

  @override
  State<AgendaEntry> createState() => _AgendaEntryState();
}

class _AgendaEntryState extends State<AgendaEntry> {

  String get currentLanguageCode => Localizations.localeOf(context).languageCode;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform:  Matrix4.translationValues(-30.0, 0.0, 0.0),
          child: GestureDetector(
            onTap: () => {Navigator.of(context).pop()},
            child: Text(
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
      height: 1000,
    );
  }

}