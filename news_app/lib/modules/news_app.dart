import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/main_cubit.dart';
import 'package:news_app/layout/news_cubit.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/modules/search_screen.dart';
import 'package:news_app/shered/components/components.dart';
import 'package:news_app/shered/components/constants.dart';

class news_app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<news_cubit, news_states>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = news_cubit.get(context);
          var cubit2 = main_cubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: cubit2.isArabic ? Text('اخبار اليوم') : Text('today news'),
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.search = [];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => search_screen()));
                    },
                    icon: Icon(
                      Icons.search,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {
                      cubit2.Islight();
                    },
                    icon: cubit2.light
                        ? Icon(Icons.nights_stay_outlined)
                        : Icon(Icons.wb_sunny_outlined)),
                IconButton(
                    onPressed: () {
                      changelanguage(context);
                    },
                    icon: Icon(Icons.language_outlined)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.Currentindex,
              onTap: (index) {
                cubit.currentindex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.business), label: " Business"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sports_basketball_rounded),
                    label: "Sports"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.science), label: "Science"),
              ],
            ),
            body: cubit.Screens[cubit.Currentindex],
          );
        });
  }
}
