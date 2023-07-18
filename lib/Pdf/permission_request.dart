import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyddb23_flutter/Components/my_text.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wyddb23_flutter/language_constants.dart';

import '../Activities/pdf_viewer.dart';

class PermissionRequest{
  
  static void requestPermission(BuildContext context, String asset, String title) async {
    if(await Permission.storage.request().isGranted)
    {
/*       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PdfViewer(path: asset, title: title)),
      ); */
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PdfViewer(path: asset ,title: title)),
      );
      //await OpenFilex.open(asset);
    }
    else
    {
      _showPermissionDialog(context);
    }
  }

  static Future<void> _showPermissionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translation(context).noPermission),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(translation(context).noPermissionParagraph),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(translation(context).close, style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(translation(context).givePermission, style: TextStyle(color: WydColors.red),),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}