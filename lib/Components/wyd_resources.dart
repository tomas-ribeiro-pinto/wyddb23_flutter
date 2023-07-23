import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';


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
              'h2': Style(fontSize: FontSize(screenSize.width * 0.052)),
              'h1': Style(fontSize: FontSize(screenSize.width * 0.052)),
              'p': Style(fontSize: FontSize(getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02))),
              'div': Style(fontSize: FontSize(getResponsiveValue(screenSize, screenSize.height * 0.025, screenSize.height * 0.02, screenSize.height * 0.02))),
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

  static double getResponsiveValue(Size screenSize, double sm, double md, double lg)
  {
    if(screenSize.height > 650 && screenSize.height < 670)
    {
      return sm;
    }
    else if(screenSize.height > 670 && screenSize.height < 850)
    {
      return md;
    }
    else if(screenSize.height > 850)
    {
      return lg;
    }

    return sm;
  }

  static double getResponsiveSmValue(Size screenSize, double xs, double sm, double md, double lg)
  {
    if(screenSize.height > 650 && screenSize.height < 670)
    {
      return sm;
    }
    else if(screenSize.height > 670 && screenSize.height < 850)
    {
      return md;
    }
    else if(screenSize.height > 850)
    {
      return lg;
    }

    return xs;
  }

  static Future<File> loadPdfUrl(String url) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  static Future<File> loadPdfAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}