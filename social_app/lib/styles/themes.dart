import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darktheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 18, 18, 19),
  cardColor: Colors.white,
  scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 19),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Color.fromARGB(255, 221, 223, 201)),
    color: Color.fromARGB(255, 18, 18, 19),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Opificio_Bold_rounded',
      fontSize: 30,
      color: Color.fromARGB(255, 221, 223, 201),
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 18, 18, 19),
        statusBarIconBrightness: Brightness.light),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontFamily: 'Tajawal',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 18, 18, 19),
    ),
    bodyText2: TextStyle(
      fontFamily: 'Opificio_Bold_rounded',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 221, 223, 201),
    ),
  ),
);
ThemeData lighttheme = ThemeData(
  primaryColor: Colors.indigo[900],
  cardColor: Colors.white,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontFamily: 'Tajawal',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontFamily: 'Opificio_Bold_rounded',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1A237E),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.indigo[900],
      ),
      titleTextStyle: const TextStyle(
        fontFamily: 'Opificio_Bold_rounded',
        fontSize: 30,
        color: Color.fromRGBO(26, 35, 126, 1),
        fontWeight: FontWeight.bold,
      ),
      color: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0.0,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: Colors.white,
  ),
);
