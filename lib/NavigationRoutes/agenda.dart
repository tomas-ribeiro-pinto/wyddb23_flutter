import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:wyddb23_flutter/Components/agenda_tab_bar.dart';
import '../APIs/WydAPI/api_service.dart';
import '../APIs/WydAPI/day_model.dart';
import '../Components/my_text.dart';
import '../language_constants.dart';
import 'package:wyddb23_flutter/Components/agenda_list.dart';

class Agenda extends StatefulWidget {
  const Agenda({Key? key}) : super(key: key);

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {

  late List<Day>? _agendaModel = null;

  @override
  void initState() {
    super.initState();
    _getTimetable();
  }

  void _getTimetable() async {
    _agendaModel = (await WydApiService().getTimetable());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: 100,
          color: Color(0xFFd53f28),
        ),
        SafeArea(
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
                                child: MyText(
                                  translation(context).agenda.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: screenSize.height * 0.04,
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                      content: Container(
                      color: Colors.white,
                      child: Column(
                      children: [
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
          if(_agendaModel != null)...
          {
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.24),
              child: AgendaTabBar(agendaModel: _agendaModel),
            ),
          }
          else...
          {
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    translation(context).loading + '...',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF028744),
                      fontSize: 20
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator( //Adds a Loading Indicator
                      color: Color(0xFFf6be18),
                    ),
                  ),
                ],
              ),
            ),
          },
      ],
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