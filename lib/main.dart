import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wyddb23_flutter/Notifications/notification_service.dart';
import 'package:wyddb23_flutter/language_constants.dart';
import 'Activities/splash.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

// used to pass messages from event handler to the UI
final _messageStreamController = BehaviorSubject<RemoteMessage>();

// Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 await Firebase.initializeApp();

 if (kDebugMode) {
   print("Handling a background message: ${message.messageId}");
   print('Message data: ${message.data}');
   print('Message notification: ${message.notification?.title}');
   print('Message notification: ${message.notification?.body}');
 }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 // Request permission

  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
  );

  // Register with FCM

  final fcmToken = await FirebaseMessaging.instance.getToken();
   if (kDebugMode) {
    print(fcmToken);
   }

  // Set up foreground message handler

  // used to pass messages from event handler to the UI
  final _messageStreamController = BehaviorSubject<RemoteMessage>(); 
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
   if (kDebugMode) {
     print('Handling a foreground message: ${message.messageId}');
     print('Message data: ${message.data}');
     print('Message notification: ${message.notification?.title}');
     print('Message notification: ${message.notification?.body}');
   }

   _messageStreamController.sink.add(message);
 });

  // TODO: Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
/*   FirebaseMessaging.instance.onTokenRefresh
    .listen((fcmToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
    .onError((err) {
      // Error getting token.
    }); */

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
  String _lastMessage = "";

  _MyAppState() {
    _messageStreamController.listen((message) {
      setState(() {
        if (message.notification != null) {
          _lastMessage = 'Received a notification message:'
              '\nTitle=${message.notification?.title},'
              '\nBody=${message.notification?.body},'
              '\nData=${message.data}';
        } else {
          _lastMessage = 'Received a data message: ${message.data}';
        }
      });
    });
  }


  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {    
    // Set Android Status Bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
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
