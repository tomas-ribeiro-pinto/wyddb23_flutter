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
              'h2': Style(fontSize: FontSize(screenSize.width * 0.045)),
              'p': Style(fontSize: FontSize(screenSize.width * 0.04)),
              '.red': Style(color: WydColors.red),
              '.green': Style(color: WydColors.green),
              '.yellow': Style(color: WydColors.yellow),
            };
                    
  }
}