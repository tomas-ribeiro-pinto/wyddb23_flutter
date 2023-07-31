import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wyddb23_flutter/Activities/Guide/guide_activity.dart';
import 'package:wyddb23_flutter/Activities/Prayers/prayers_activity.dart';
import 'package:wyddb23_flutter/Activities/Welcome/welcome_activity.dart';
import 'package:wyddb23_flutter/Activities/boot.dart';
import 'package:wyddb23_flutter/Activities/home_activity.dart'; 
import 'package:wyddb23_flutter/NavigationRoutes/sym_day_page.dart';
import 'package:wyddb23_flutter/Notifications/notification_service.dart';
import 'package:wyddb23_flutter/language_constants.dart';
import 'APIs/WydAPI/api_response_box.dart';
import 'APIs/WydAPI/notification_response_box.dart';
import 'Activities/splash.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'Notifications/notification.dart' as noti;
import 'package:wyddb23_flutter/Notifications/notification.dart' as notification;

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

  // Initialize Local Notifications
  NotificationService().initNotification();
  tz.initializeTimeZones();

  // Set up Hive NoSQL
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ApiResponseBoxAdapter());
  Hive.registerAdapter(NotificationResponseBoxAdapter());

  // Set up preferred orientation,
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // used to pass messages from event handler to the UI
  final _messageStreamController = BehaviorSubject<RemoteMessage>(); 
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

    NotificationService().showNotification(title: message.notification?.title, body: message.notification?.body);
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
  
  FirebaseMessaging.instance.onTokenRefresh
    .listen((fcmToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
    .onError((err) {
      // Error getting token.
    });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    Locale currentLocale = Localizations.localeOf(context);
    unsubscribeFromTopic(currentLocale.languageCode);
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  // subscribe to language topic
  static void subscribeToTopic(String locale) async
  {
    await FirebaseMessaging.instance.subscribeToTopic(locale);
  }

  // unsubscribe from language topic
  static void unsubscribeFromTopic(String locale) async
  {
    await FirebaseMessaging.instance.unsubscribeFromTopic(locale);
  }
}

class _MyAppState extends State<MyApp> {
  String _lastMessage = "";
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

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
    setState((){
      _locale = locale;
      // subscribe to language topic
      subscribeToTopic(locale.languageCode);
    });
  }

// subscribe to language topic
  void subscribeToTopic(String locale) async
  {
    await FirebaseMessaging.instance.subscribeToTopic(locale);
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
          Locale('it'), // Italian
          Locale('es'), // Spanish
        ],
        locale: _locale,

        // Routes
        navigatorKey: navigatorKey,
        routes: {
          '/home': (context) => const HomeActivity(pageIndex: 0,),
          '/accommodation': (context) => const HomeActivity(pageIndex: 1,),
          '/visit': (context) => const HomeActivity(pageIndex: 2,),
          '/symDay': (context) => const HomeActivity(pageIndex: 3,),
          '/agenda': (context) => const HomeActivity(pageIndex: 4,),
          '/welcome': (context) => const WelcomeActivity(),
          '/prayers': (context) => const PrayersActivity(),
          '/guides': (context) => const GuideActivity(),
        },

        // App Theme
        theme: ThemeData(
          fontFamily: 'Rubik',
          colorScheme: ColorScheme.fromSeed(
            //seedColor: const Color(0xFF028744),
            seedColor: Colors.black.withOpacity(0.8),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        // Run the Boot and Splash Screen before loading app
        home: Boot()
        );
  }
}
