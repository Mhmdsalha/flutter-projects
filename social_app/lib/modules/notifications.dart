import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/modules/home_screen.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/styles/textstyle.dart';
import 'package:shop/layout/social_cubit_home.dart';

class notifications_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      social_cubit_home.get(context).getNotificationstoFirebase();
      return BlocConsumer<social_cubit_home, social_app_states>(
        listener: (context, state) {
          if (state is addfriend_success) {
            toastbuilder('Successfully added to friends list', context);
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: textstyle(
                    context: context,
                    arabicText: 'الاشعارت',
                    englishText: 'Notifications',
                    fontsize: 25,
                    TextAlign: TextAlign.start,
                    color: Colors.deepOrange),
                actions: [
                  IconButton(
                      onPressed: () {
                        social_cubit_home
                            .get(context)
                            .deleteNotificationstoFirebase();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.deepOrange,
                      ))
                ],
              ),
              body: notificationsBuilderScreen(context));
        },
      );
    });
  }
}
