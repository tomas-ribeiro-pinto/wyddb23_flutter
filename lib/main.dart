import 'package:flutter/material.dart';
import 'Activities/splash.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {    
    // Set Android Status Bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF028744),
    ));
    
    return MaterialApp(
        title: 'WYD Don Bosco 23',
        // Localizations
        localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        supportedLocales: [
          Locale('en'), // English
          Locale('pt'), // Portuguese
        ],
        locale: _locale,

        // App Theme
        theme: ThemeData(
          fontFamily: 'Rubik',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF028744),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        // Run the Splash Screen before loading app
        home: const Splash()
        );
  }
}
