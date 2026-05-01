import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/layout/social_cubit_profile.dart';
import 'package:shop/models/post_model.dart';
import 'package:shop/models/usermodel.dart';
import 'package:shop/modules/settings.dart';
import 'package:shop/modules/updateprofile.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/textstyle.dart';

class profileusers extends StatelessWidget {
  usermodel? model;
  profileusers(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<social_cubit_home, social_app_states>(
        listener: (context, state) {
      if (state is sendfriendsRequest_success) {
        social_cubit_home.get(context).SendNotifications(
              title:
                  '${social_cubit_home.get(context).usermodel_object?.name} sent you Friends Request ',
              body: '',
              token: '${model?.token}',
              receiveruid: '${model?.uid}',
              senderuid: '${Uid}',
              friendsRequest: true,
              sendername:
                  '${social_cubit_home.get(context).usermodel_object?.name} ',
              receivername: '${model?.name}',
              senderprofileimage:
                  '${social_cubit_home.get(context).usermodel_object?.profilephoto}',
              receiverprofileimage: '${model?.profilephoto}',
            );
      }
    }, builder: (context, state) {
      //var model = social_cubit_home.get(context).Usersprofilemodel;
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 225,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Image(
                          image: NetworkImage('${model?.cover}'),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('${model?.profilephoto}'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              textstyle(
                  context: context,
                  arabicText: '${model?.name}',
                  englishText: '${model?.name}',
                  fontsize: 20,
                  TextAlign: TextAlign.center,
                  color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 250,
                child: Center(
                  child: textstyle(
                      maxline: 3,
                      context: context,
                      arabicText: '${model?.bio}',
                      englishText: '${model?.bio}',
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
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '${social_cubit_home.get(context).allUsersPosts?[model?.uid]?.length}',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '${social_cubit_home.get(context).allUsersfriendsnum?[model?.uid]}',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'Friends',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: social_cubit_home
                              .get(context)
                              .myfriendsid
                              .contains(model?.uid)
                          ? Column(
                              children: [
                                const Icon(
                                  IconlyBroken.user_2,
                                  color: Colors.deepOrange,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Friends',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: () {
                                social_cubit_home
                                    .get(context)
                                    .sendFriendsRequest(
                                      '${model?.uid}',
                                    );
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    IconlyBroken.add_user,
                                    color: Colors.deepOrange,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Add Friend',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: textstyle(
                      context: context,
                      arabicText: '${model?.name} post\'s ',
                      englishText: '${model?.name} post\'s ',
                      fontsize: 20,
                      TextAlign: TextAlign.start,
                      color: Colors.deepOrange),
                ),
              ),
              social_cubit_home.get(context).allUsersPosts?[model?.uid] != []
                  ? social_cubit_home
                          .get(context)
                          .myfriendsid
                          .contains(model?.uid)
                      ? allUsersPostBuilderScreen(context, model?.uid)
                      : Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            textstyle(
                                context: context,
                                arabicText: 'يمكن للاصدقاء فقط رؤية منشوراتي',
                                englishText: 'Only friend\'s can see my posts',
                                fontsize: 20,
                                TextAlign: TextAlign.center,
                                color: Colors.deepOrange),
                          ],
                        )
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
                            height: MediaQuery.of(context).size.height / 4.0,
                            width: MediaQuery.of(context).size.width / 0.5,
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
  }
}
