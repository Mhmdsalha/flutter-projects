import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/shop_cubit_update_profile.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/modules/shop_screen.dart';
import 'package:shop/modules/login.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/themes.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/shered/Network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dio_helper.init();

  await cache_helper.init();
  bool? light = cache_helper.getdate(key: 'light');
  bool? isArabic = cache_helper.getdate(key: 'isArabic');
  bool? skipOnboarding = cache_helper.getdate(key: 'onboarding');
  token = cache_helper.getdate(key: 'token');
  name = cache_helper.getdate(key: 'name');
  print(token);

  if (token != null) {
    print('home');
    startscreen = home_screen();
  } else {
    print('login');
    startscreen = login_screen();
  }

  runApp(
    MyApp(
      isArabic: isArabic,
      token: token,
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
  final String? token;
  final String? name;

  const MyApp(
      {this.light,
      this.name,
      required this.startwidget,
      this.token,
      this.isArabic});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => main_cubit()
                ..Islight(form_shered: light)
                ..isarabic(form_shered2: isArabic)),
          BlocProvider(
            create: (BuildContext context) => shop_cubit_update_profile(),
          ),
          BlocProvider(
              create: (BuildContext context) => shop_cubit_home()
                ..gethomedata()
                ..get_category_data()
                ..get_favorites_data()
                ..get_profile_data()
                ..get_cart_data()),
        ],
        child: BlocConsumer<main_cubit, shop_states>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lighttheme,
                darkTheme: darktheme,
                themeMode: main_cubit.get(context).light
                    ? ThemeMode.light
                    : ThemeMode.dark,
                home: main_cubit.get(context).isArabic
                    ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: SPLASHSCREEN(startwidget, context),
                      )
                    : Directionality(
                        textDirection: TextDirection.ltr,
                        child: SPLASHSCREEN(startwidget, context),
                      ),
              );
            }));
  }
}
