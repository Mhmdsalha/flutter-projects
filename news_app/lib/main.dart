import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/main_cubit.dart';
import 'package:news_app/modules/news_app.dart';
import 'package:news_app/layout/news_cubit.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/shered/Network/local/cache_helper.dart';
import 'package:news_app/shered/Network/remote/dio_helper.dart';
import 'package:news_app/shered/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dio_helper.init();

  await cache_helper.init();

  bool? light = cache_helper.getdate(key: 'light');
  isArabic = cache_helper.getdate(key: 'isArabic')!;
  runApp(MyApp(light, isArabic));
}

class MyApp extends StatelessWidget {
  final bool? light;
  final bool? isArabic;
  MyApp(this.light, this.isArabic);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => news_cubit()..getBusiness(),
        ),
        BlocProvider(
            create: (BuildContext context) => main_cubit()
              ..Islight(form_shered: light)
              ..isarabic(form_shered2: isArabic)),
      ],
      child: BlocConsumer<main_cubit, news_states>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: Colors.indigo[900],
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[900],
                    ),
                    bodyText2: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(
                        color: Colors.indigo[900],
                      ),
                      titleTextStyle: TextStyle(
                          color: Colors.indigo[900],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lenos'),
                      color: Colors.white,
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark)),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    elevation: 0.0,
                    showUnselectedLabels: false,
                    unselectedItemColor: Colors.indigo[900],
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.indigo[900],
                    backgroundColor: Colors.white,
                  ),
                ),
                darkTheme: ThemeData(
                  primaryColor: Colors.white,
                  scaffoldBackgroundColor: Colors.indigo[900],
                  appBarTheme: AppBarTheme(
                    color: Colors.indigo[900],
                    elevation: 0.0,
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    titleTextStyle: TextStyle(
                      fontFamily: 'Lenos',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.indigo[900],
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    elevation: 0.0,
                    showUnselectedLabels: false,
                    unselectedItemColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.white,
                    backgroundColor: Colors.indigo[900],
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    bodyText2: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                themeMode: main_cubit.get(context).light
                    ? ThemeMode.light
                    : ThemeMode.dark,
                home: main_cubit.get(context).isArabic
                    ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: news_app(),
                      )
                    : Directionality(
                        textDirection: TextDirection.ltr,
                        child: news_app(),
                      ));
          }),
    );
  }
}
