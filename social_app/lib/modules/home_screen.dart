import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:path/path.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/modules/add_post.dart';
import 'package:shop/modules/notifications.dart';
import 'package:shop/modules/search.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/textstyle.dart';

class home_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      social_cubit_home.get(context).getNotificationstoFirebase();

      return BlocConsumer<social_cubit_home, social_app_states>(
        listener: (context, state) {
          if (state is addNewPostState) {
            social_cubit_home.get(context).usermodel_object = null;
            social_cubit_home.get(context).getUserData();
            social_cubit_home.get(context).postimage = null;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => addPost_screen()));
          }
        },
        builder: (context, state) {
          return Scaffold(
              extendBody: true,
              appBar: AppBar(
                  title: textstyle(
                      context: context,
                      arabicText: social_cubit_home.get(context).appBarTitelArb[
                          social_cubit_home.get(context).Currentindex],
                      englishText:
                          social_cubit_home.get(context).appBarTitelEng[
                              social_cubit_home.get(context).Currentindex],
                      fontsize: 30,
                      TextAlign: TextAlign.center,
                      color: Colors.deepOrange),
                  actions: [
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              social_cubit_home
                                  .get(context)
                                  .Notificationsnum[Uid!] = 0;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          notifications_screen()));
                            },
                            icon: Icon(IconlyBroken.notification)),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.deepOrange,
                          child: Text(
                              '${social_cubit_home.get(context).Notificationsnum[Uid] ?? 0} ',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => search_screen()));
                        },
                        icon: Icon(IconlyBroken.search)),
                  ]),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: social_cubit_home.get(context).Currentindex,
                onTap: (index) {
                  social_cubit_home.get(context).currentindex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(IconlyBroken.home), label: " Home"),
                  BottomNavigationBarItem(
                      icon: Icon(IconlyBroken.chat), label: "Chats"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), label: "Add Post"),
                  BottomNavigationBarItem(
                      icon: Icon(IconlyBroken.user_3), label: "User"),
                  BottomNavigationBarItem(
                      icon: Icon(IconlyBroken.profile), label: "Profile"),
                ],
              ),
              body: social_cubit_home
                  .get(context)
                  .Screens[social_cubit_home.get(context).Currentindex]);
        },
      );
    });
  }
}
