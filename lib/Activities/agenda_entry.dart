import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';

import '../APIs/WydAPI/Models/agenda_model.dart';
import '../Components/my_text.dart';
import '../Components/wyd_resources.dart';

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
            translation(context).agenda.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: WydColors.yellow,
              fontSize: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        ),
        backgroundColor: WydColors.red,
        surfaceTintColor: WydColors.red,
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: Header(
        title: widget.entry!.getTranslatedTitleAttribute(currentLanguageCode).toUpperCase(),
        titleColor: Colors.white,
        color: WydColors.red,
        content: getEntryContent(),
        hasBanner: false,
      ),
    );
  }

  Container getEntryContent()
  {
    Size screenSize = MediaQuery.of(context).size;

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
                  if(widget.entry.startTime != null)...
                  {
                    MyText(
                    widget.entry.endTime != null
                          ? formatter.format(widget.entry.startTime!) + ' - ' + formatter.format(widget.entry.endTime!) 
                          : formatter.format(widget.entry.startTime!),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: WydColors.yellow,
                      fontSize: 20
                    ),
                    ),
                  },
                  Row(
                    children: [
                      HeroIcon(
                        HeroIcons.mapPin,
                        style: HeroIconStyle.solid,
                        color: WydColors.green,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: MyText(
                          widget.entry.location,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  getEntryDescription()
                ],
              ),
              Container(
                height: screenSize.height * 0.17,
              )
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