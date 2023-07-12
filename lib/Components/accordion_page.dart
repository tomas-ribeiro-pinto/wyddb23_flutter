import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';

import '../APIs/WydAPI/Models/faq_model.dart';
import 'my_text.dart';

class AccordionPage
{
  Container getFaqAccordion(BuildContext context, List<Faq>? faqModel, String locale)
  {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Accordion(
            maxOpenSections: 1,
            disableScrolling: true,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            headerPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            children: [
              if(faqModel != null)...
              {
                for(Faq faq in faqModel!)...
              {
                AccordionSection(
                  isOpen: true,
                  contentBackgroundColor: Color.fromARGB(255, 242, 242, 242),
                  headerBackgroundColor: WydColors.yellow,
                  headerBackgroundColorOpened: WydColors.yellow,
                  header: MyText(
                  faq.getTranslatedQuestionAttribute(locale),
                  style: TextStyle(fontSize: screenSize.width * 0.045,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)
                  ),
                  content: MyText(
                  faq.getTranslatedAnswerAttribute(locale),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: screenSize.width * 0.045,
                              color: Colors.black)
                  ),
                  headerPadding: EdgeInsets.all( screenSize.width * 0.04),
                  contentHorizontalPadding: screenSize.width * 0.06,
                  contentBorderWidth: 0,
                ),  
              },
              }
            ],
          ),
        ],
      ),
    );
  }

  Container getHealthAccordion(BuildContext context, Map<String, String> sections)
  {
    Size screenSize = MediaQuery.of(context).size;

    Map<String, String> info_sections = {
      'section1': sections['section1']!,
      'section2': sections['section2']!,
      'section3': sections['section3']!,
    };
    
    Map<String, String> advices = {
      'section4': sections['section4']!,
      'section5': sections['section5']!,
      'section6': sections['section6']!,
      'section7': sections['section7']!,
      'section8': sections['section8']!,
      'section9': sections['section9']!,
      'section10': sections['section10']!,
    };

    return Container(
      child: Column(
        children: [
          Html(
            data: sections['header'],
            style: WydResources.htmlStyle(context),
          ),
          Accordion(
            maxOpenSections: 1,
            disableScrolling: true,
            headerBackgroundColorOpened: WydColors.green,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            headerPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            children: [
              for(String value in info_sections.values)...
              {
                AccordionSection(
                  isOpen: true,
                  //leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                  contentBackgroundColor: Color.fromARGB(255, 242, 242, 242),
                  headerBackgroundColor: WydColors.green,
                  headerBackgroundColorOpened: WydColors.green,
                  header: Html(
                    data: getSectionContent(value)[0],
                    style: {
                      'h2': Style(fontSize: FontSize(screenSize.width * 0.045),
                                  color: Colors.white)
                      }
                  ),
                  content: Html(
                      data: getSectionContent(value)[1],
                      style: WydResources.htmlStyle(context),
                    ),
                  contentHorizontalPadding: screenSize.width * 0.02,
                  contentVerticalPadding: screenSize.width * 0,
                  contentBorderWidth: 0,
                ),  
              },
            ],
          ),
          Html(
              data: sections['inter_section'],
              style: WydResources.htmlStyle(context),
            ),
          Accordion(
            maxOpenSections: 1,
            disableScrolling: true,
            headerBackgroundColorOpened: WydColors.green,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            headerPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            children: [
              for(String value in advices.values)...
              {
                AccordionSection(
                  isOpen: true,
                  //leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                  contentBackgroundColor: Color.fromARGB(255, 242, 242, 242),
                  headerBackgroundColor: WydColors.red,
                  headerBackgroundColorOpened: WydColors.red,
                  header: Html(
                    data: getSectionContent(value)[0],
                    style: {
                      'h2': Style(fontSize: FontSize(screenSize.width * 0.045),
                                  color: Colors.white)
                      }
                  ),
                  content: Html(
                      data: getSectionContent(value)[1],
                      style: WydResources.htmlStyle(context),
                    ),
                  contentHorizontalPadding: 20,
                  contentVerticalPadding: 0,
                  contentBorderWidth: 0,
                ),  
              },
            ],
          ),
        ],
      ),
    );
  }

  List<String> getSectionContent(String section)
  {
    return section.split("*break*");
  }
} 