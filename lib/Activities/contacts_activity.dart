import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyddb23_flutter/Components/header.dart';
import 'package:wyddb23_flutter/Components/navigation_bar.dart' as Components;
import 'package:wyddb23_flutter/language_constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:accordion/accordion.dart';

import '../../Components/my_text.dart';
import '../../Components/wyd_resources.dart';
import '../APIs/WydAPI/Models/contact_model.dart';
import '../APIs/WydAPI/Models/faq_model.dart';
import '../APIs/WydAPI/api_cache_helper.dart';
import '../Components/accordion_page.dart';

class ContactsActivity extends StatefulWidget {
  const ContactsActivity({Key? key}) : super(key: key);

  @override
  State<ContactsActivity> createState() => _ContactsActivityState();
}

class _ContactsActivityState extends State<ContactsActivity> {
  String get currentLanguageCode => Localizations.localeOf(context).languageCode;
  List<Contact>? _contactModel = null;

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  void _getContacts() async {
    _contactModel = (await ApiCacheHelper.getContacts());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

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
            translation(context).home.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: WydColors.yellow,
              fontSize: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        ),
        backgroundColor: WydColors.green,
        surfaceTintColor: WydColors.green,
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: Components.NavigationBar(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              decoration: BoxDecoration(
                color: WydColors.green,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                child: MyText(
                  translation(context).contacts,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: screenSize.height * 0.04,
                  ),
                ),
              ),
            ),
            getEntryContent()
          ],
        ),
      )
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
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              if(_contactModel != null)...
              {
                for(Contact contact in _contactModel!)...
                {
                  getContactCard(screenSize, contact),
                }
              }
            ],
          ),
        )
      ),
    );
  }

  Container getContactCard(Size screenSize, Contact contact) {
    return Container(
              constraints: BoxConstraints(
                minHeight: screenSize.width * 0.2,
              ),
              width: screenSize.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            contact.person,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: screenSize.height * 0.02,
                            ),
                          ),
                          MyText(contact.getTranslatedDescriptionAttribute(currentLanguageCode)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: screenSize.width * 0.12,
                    margin: EdgeInsets.only(right: 20),
                    child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return WydColors.red;
                      }),
                    ),
                    onPressed: () {
                      launchUrl(Uri.parse('tel:' + contact.contact));
                    },
                    child: Container(
                      width: screenSize.width * 0.25,
                      alignment: Alignment.center,
                      child: MyText(
                      translation(context).call.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: screenSize.height * 0.014,
                        ),
                      ),
                    ),
                                    ),
                  ),
                ],
              ),
            );
  }
}