import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/layout/social_cubit_profile.dart';
import 'package:shop/modules/settings.dart';
import 'package:shop/modules/updateprofile.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/Adaptive.dart';
import 'package:shop/styles/textstyle.dart';

class profile_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      social_cubit_home.get(context).getallusersPosts('${Uid}');
      return BlocConsumer<social_cubit_home, social_app_states>(
          listener: (context, state) {},
          builder: (context, state) {
            var model = social_cubit_home.get(context).usermodel_object;
            return Scaffold(
              body: model == null
                  ? Center(child: adaptive(os: getos()))
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            height: 225,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: coverimageCachedImage(
                                        '${model.cover}')),
                                profileimageCachedImage('${model.profilephoto}')
                              ],
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textstyle(
                                    context: context,
                                    arabicText: '${model.name}',
                                    englishText: '${model.name}',
                                    fontsize: 20,
                                    TextAlign: TextAlign.center,
                                    color: Colors.black),
                                if (FirebaseAuth
                                        .instance.currentUser?.emailVerified ==
                                    true)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 16,
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 250,
                            child: Center(
                              child: textstyle(
                                  maxline: 3,
                                  context: context,
                                  arabicText: '${model.bio}',
                                  englishText: '${model.bio}',
                                  fontsize: 15,
                                  TextAlign: TextAlign.center,
                                  color: Colors.grey),
                            ),
                          ),
                          const SingleChildScrollView(
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${social_cubit_home.get(context).allUsersPosts?[Uid]?.length ?? '0'}  ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      Text(
                                        'Posts',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Column(
                                      children: [
                                        Text(
                                          '${social_cubit_home.get(context).myfriendslist.length}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        Text(
                                          'Friends',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: defultbutton(
                                        height: 40,
                                        Color: Colors.deepOrange,
                                        function: () {
                                          social_cubit_profile
                                              .get(context)
                                              .coverimage = null;
                                          social_cubit_profile
                                              .get(context)
                                              .profileimage = null;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      updateprofile_screen()));
                                        },
                                        buttontextArabic: 'تعديل الملف الشخصي',
                                        buttontextEnglish: 'EDIT PROFILE',
                                        context: context),
                                  ),
                                  Expanded(
                                      child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        settings_screen()));
                                          },
                                          icon: Icon(
                                            IconlyBold.setting,
                                            color: Colors.deepOrange,
                                          )))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: textstyle(
                                    context: context,
                                    arabicText: 'منشوراتي',
                                    englishText: 'My Posts',
                                    fontsize: 25,
                                    TextAlign: TextAlign.start,
                                    color: Colors.deepOrange)),
                          ),
                          social_cubit_home.get(context).allUsersPosts?[Uid] !=
                                  []
                              ? allUsersPostBuilderScreen(context, Uid)
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    textstyle(
                                        context: context,
                                        arabicText: 'لا توجد منشورات',
                                        englishText: 'No posts yet',
                                        fontsize: 20,
                                        TextAlign: TextAlign.center,
                                        color: Colors.deepOrange),
                                    Image(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4.0,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                0.5,
                                        image: const AssetImage(
                                            'lib/assets/images/6ad1d1eba400880e3c3de062fcb13576.png')),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
            );
          });
    });
  }
}
