
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:wyddb23_flutter/Activities/agenda_entry.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';

import '../APIs/WydAPI/Models/prayer_model.dart';
import '../Activities/Prayers/prayers_entry.dart';
import '../language_constants.dart';
import 'my_text.dart';

class PrayersList extends StatefulWidget {
  const PrayersList({Key? key, this.prayers}) : super(key: key);

  final List<Prayer>? prayers;

  @override
  State<PrayersList> createState() => _PrayersListState();
}

class _PrayersListState extends State<PrayersList> {

  DateFormat formatter = DateFormat('HH:mm');
  
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<Prayer> prayers = widget.prayers ?? List.empty();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.start,
          spacing: 10,
          children: [
            if(!prayers.isEmpty)...
            {
              for(Prayer prayer in prayers)...
              {
                getPrayerCard(screenSize, prayer),
              },
              Container(
              color: Colors.white,
              child: Column(
              children: [
                Container(
                  height: 150,
                  color: Colors.transparent,
                  ),
                  ],
                ),
              ),
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
                          color: WydColors.green,
                          fontSize: screenSize.width * 0.05
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            }
          ],
      ),
    );
  }

  Container getPrayerCard(Size screenSize, Prayer prayer) {
    return Container(
      child: Container(
        constraints: BoxConstraints(
          minHeight: screenSize.width * 0.2,
        ),
        width: screenSize.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.1,
              blurRadius: 10
            )
          ]
        ),
        child: TextButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrayersEntry(title: prayer.getTranslatedTitleAttribute(currentLanguageCode), body: prayer.getTranslatedBodyAttribute(currentLanguageCode))),
            )
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenSize.width * 0.12,
                margin: EdgeInsets.only(left: 20),
                child: HeroIcon(
                  HeroIcons.document,
                  style: HeroIconStyle.solid,
                  color: Colors.grey[800],
                )
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: MyText(
                    prayer.getTranslatedTitleAttribute(currentLanguageCode),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: WydResources.getResponsiveValue(screenSize, screenSize.height * 0.03, screenSize.height * 0.025, screenSize.height * 0.025),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}