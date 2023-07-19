import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_cache_helper.dart';
import 'package:wyddb23_flutter/Components/agenda_tab_bar.dart';
import 'package:wyddb23_flutter/Components/check_connection.dart';
import '../APIs/WydAPI/api_service.dart';
import '../APIs/WydAPI/Models/agenda_model.dart';
import '../Components/my_text.dart';
import '../Components/wyd_resources.dart';
import '../language_constants.dart';
import 'package:wyddb23_flutter/Components/agenda_list.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {

  late List<Day>? _agendaModel = null;

  @override
  void initState() {
    super.initState();
    _getAgenda();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getAgenda() async {
    _agendaModel = (await ApiCacheHelper.getAgenda());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: 100,
          color: WydColors.red,
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
                                color: WydColors.red,
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
                            CheckConnection()
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
                      color: WydColors.green,
                      fontSize: 20
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator( //Adds a Loading Indicator
                      color: WydColors.yellow,
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
          color: WydColors.red,
        ),
      );
  }
}