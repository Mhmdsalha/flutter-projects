import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/layout/social_cubit_login.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_profile.dart';
import 'package:shop/layout/social_cubit_register.dart';
import 'package:shop/models/notifications_model.dart';
import 'package:shop/modules/home_screen.dart';
import 'package:shop/modules/login.dart';
import 'package:shop/modules/welcomeScreen.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/themes.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/shered/Network/remote/dio_helper.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  //Foreground messages

  FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  //Background messages
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  dio_helper.init();

  await cache_helper.init();
  bool? light = cache_helper.getdate(key: 'light');
  bool? isArabic = cache_helper.getdate(key: 'isArabic');
  Uid = cache_helper.getdate(key: 'Uid');
  Token = cache_helper.getdate(key: 'token');
  name = cache_helper.getdate(key: 'name');
  skipwelcomeScreen = cache_helper.getdate(key: 'skipwelcomeScreen');
  print(Uid);
  print(Token);

  if (skipwelcomeScreen == true) {
    if (Uid != null) {
      print('home');
      startscreen = home_screen();
    } else {
      print('login');
      startscreen = login_screen();
    }
  } else {
    startscreen = welcome_screen();
  }

  runApp(
    MyApp(
      isArabic: isArabic,
      Uid: Uid,
      light: light,
      startwidget: startscreen!,
      name: name,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? light;
  final bool? isArabic;
  final Widget startwidget;
  final String? Uid;
  final String? name;

  const MyApp(
      {this.light,
      this.name,
      required this.startwidget,
      this.Uid,
      this.isArabic});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => main_cubit()),
          BlocProvider(
              create: (BuildContext context) => social_cubit_profile()),
          BlocProvider(
              create: (BuildContext context) => social_cubit_home()
                ..getUserData()
                ..getmyfriends()
                ..getPosts()
                ..getNotificationstoFirebase()
                ..getAllUsers()),
        ],
        child: BlocConsumer<main_cubit, social_app_states>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lighttheme,
                  darkTheme: darktheme,
                  themeMode: main_cubit.get(context).light
                      ? ThemeMode.light
                      : ThemeMode.dark,
                  home: startwidget);
            }));
  }
}
