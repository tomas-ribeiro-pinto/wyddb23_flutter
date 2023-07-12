import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class WydColors{
  
  static Color green = const Color(0xFF028744);
  static Color red = const Color(0xFFd53f28);
  static Color yellow = const Color(0xFFf6be18);

}

class WydResources{

  static Map<String, Style> htmlStyle(BuildContext context) 
  {
      Size screenSize = MediaQuery.of(context).size;

      return 
            {
              'h2': Style(fontSize: FontSize(screenSize.width * 0.05)),
              'h1': Style(fontSize: FontSize(screenSize.width * 0.05)),
              'div': Style(fontSize: FontSize(screenSize.width * 0.04),
                          //padding: HtmlPaddings.only(bottom: screenSize.width * 0.05)
                          ),
              'img': Style(width: Width(screenSize.width * 0.7),
                          height: Height(screenSize.width * 0.7),
                          alignment: Alignment.centerLeft),
              '.red': Style(color: WydColors.red),
              '.green': Style(color: WydColors.green),
              '.yellow': Style(color: WydColors.yellow),
              '.center': Style(textAlign: TextAlign.center),
              '.bold': Style(fontWeight: FontWeight.bold),
              '.red-label': Style(
                                fontWeight: FontWeight.bold, 
                                color: Colors.white, 
                                fontSize: FontSize(screenSize.width * 0.045),
                                backgroundColor: WydColors.red,
                                padding: HtmlPaddings.all(15),
                                border: Border(bottom: BorderSide(color: WydColors.green, width: 3)),),
            };
                    
  }
}