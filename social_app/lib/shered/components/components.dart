import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:path/path.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/models/comment_model.dart';
import 'package:shop/models/friendsmodel.dart';
import 'package:shop/models/massage_model.dart';
import 'package:shop/models/notifications_model.dart';
import 'package:shop/models/post_model.dart';
import 'package:shop/models/usermodel.dart';
import 'package:shop/modules/Usreschat.dart';
import 'package:shop/modules/chatscreen.dart';
import 'package:shop/modules/comments.dart';
import 'package:shop/modules/profileusers.dart';
import 'package:shop/modules/users.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:shop/modules/login.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/textstyle.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:swipe_to/swipe_to.dart';

Widget postBuilderScreen(
  context,
) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => postbuilder(
          context,
          social_cubit_home.get(context).myfriendspostsList[index],
          social_cubit_home.get(context).myfriendspostsListid[index],
          index),
      separatorBuilder: (context, index) => const SizedBox(),
      itemCount: social_cubit_home.get(context).myfriendspostsList.length);
}

Widget allUsersPostBuilderScreen(context, String? uid) {
  return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => userspostbuilder(
          context,
          social_cubit_home.get(context).allUsersPosts?[uid]?[index],
          social_cubit_home.get(context).postsId[index],
          index),
      separatorBuilder: (context, index) => const SizedBox(),
      itemCount:
          social_cubit_home.get(context).allUsersPosts?[uid]?.length ?? 0);
}

Widget chatBuilderScreen(context) {
  return ListView.separated(
    controller: social_cubit_home.get(context).listScrollController,
    reverse: true,
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      var message = social_cubit_home.get(context).messageList[index];
      if (message.senderId == Uid) {
        return buildMyMassage(
          context,
          message,
        );
      }
      return buildReseiverMassage(context, message);
    },
    itemCount: social_cubit_home.get(context).messageList.length,
    separatorBuilder: (BuildContext context, int index) => SizedBox(
      height: 5,
    ),
  );
}

Widget chatuserBuilderScreen(context) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => chatusersbuilder(
            context,
            social_cubit_home.get(context).myfriendslist[index],
          ),
      separatorBuilder: (context, index) => divider(context),
      itemCount: social_cubit_home.get(context).myfriendslist.length);
}

Widget notificationsBuilderScreen(context) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => notificationsbuilder(
          social_cubit_home.get(context).Notificationslist[index],
          context,
          index),
      separatorBuilder: (context, index) => SizedBox(),
      itemCount: social_cubit_home.get(context).Notificationslist.length);
}

Widget usersBuilderScreen(context) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => usersbuilder(
            context,
            social_cubit_home.get(context).alluserlist[index],
          ),
      separatorBuilder: (context, index) => divider(context),
      itemCount: social_cubit_home.get(context).alluserlist.length);
}

Widget searchusersBuilderScreen(context) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => usersbuilder(
            context,
            social_cubit_home.get(context).searchuserslist[index],
          ),
      separatorBuilder: (context, index) => divider(context),
      itemCount: social_cubit_home.get(context).searchuserslist.length);
}

Widget commentBuilderScreen(context) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => commentBuilder(
            context,
            social_cubit_home.get(context).commentsList[index],
          ),
      separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
      itemCount: social_cubit_home.get(context).commentsList.length);
}

Widget defultbutton(
        {double width = double.infinity,
        double height = 50,
        double fontsize = 20,
        required Color Color,
        required void Function() function,
        required String buttontextArabic,
        required String buttontextEnglish,
        required context}) =>
    Container(
      decoration:
          BoxDecoration(color: Color, borderRadius: BorderRadius.circular(20)),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          main_cubit.get(context).isArabic
              ? '$buttontextArabic'
              : '$buttontextEnglish',
          style: TextStyle(
            fontFamily: main_cubit.get(context).isArabic
                ? 'NotoNaskhArabic-Bold'
                : 'Opificio_Bold_rounded',
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: main_cubit.get(context).light
                ? Theme.of(context).cardColor
                : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );

Widget defultbuttonwithicon(
        {double width = double.infinity,
        required Color Color,
        required Color Color2,
        required void Function() function,
        required String buttontextEnglish,
        required context,
        required IconData icon}) =>
    Container(
      decoration:
          BoxDecoration(color: Color, borderRadius: BorderRadius.circular(20)),
      width: width,
      height: 50,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Icon(
              icon,
              size: 30,
              color: Color2,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 8),
              child: Text(
                '$buttontextEnglish',
                style: TextStyle(
                    fontFamily: 'Opificio_Bold_rounded',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color2),
              ),
            ),
          ],
        ),
      ),
    );

Widget textbutton({
  required String buttontextArabic,
  required String buttontextEnglish,
  required Color Color,
  required context,
  required void Function() function,
  double size = 15,
}) {
  return TextButton(
    onPressed: function,
    child: Text(
      main_cubit.get(context).isArabic
          ? '$buttontextArabic'
          : '$buttontextEnglish',
      style: TextStyle(
        fontFamily: main_cubit.get(context).isArabic
            ? 'NotoNaskhArabic-Bold'
            : 'Opificio_Bold_rounded',
        color: Color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget divider(context) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.19,
    height: 1,
    color: Colors.grey.withOpacity(0.2),
  );
}

Widget divider2(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 1,
    color: Colors.grey.withOpacity(0.2),
  );
}

Widget defultTextfield(
        {final FormFieldValidator<String>? validator,
        required TextEditingController controller,
        required TextInputType keyboardType,
        Color Color = Colors.grey,
        String labelText = '',
        String hintText = '',
        required IconData prefixIcon,
        void Function(String)? onchange,
        IconData? suffixIcon,
        void Function()? suffixIconpressed,
        void Function(String)? onSubmitted,
        required context,
        required EdgeInsetsGeometry EdgeInsetsGeometry,
        required double width,
        int maxLines = 1,
        bool isPassword = false}) =>
    Container(
      margin: EdgeInsetsGeometry,
      width: width,
      child: TextFormField(
        maxLines: maxLines,
        obscureText: isPassword,
        validator: validator,
        onFieldSubmitted: onSubmitted,
        controller: controller,
        textDirection: main_cubit.get(context).isArabic
            ? TextDirection.rtl
            : TextDirection.ltr,
        style: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.bold,
          fontFamily: main_cubit.get(context).isArabic
              ? 'Tajawal'
              : 'Opificio_Bold_rounded',
        ),
        keyboardType: keyboardType,
        onChanged: onchange,
        decoration: InputDecoration(
            fillColor:
                main_cubit.get(context).light ? Colors.black12 : Colors.white12,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white12, width: 0),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            labelStyle: TextStyle(color: Color),
            hintText: hintText,
            labelText: labelText,
            prefixIcon: Icon(
              prefixIcon,
              color: Color,
            ),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: suffixIconpressed,
                    icon: Icon(
                      suffixIcon,
                      color: Color,
                    ))
                : null),
      ),
    );

Future<bool?> toastbuilder(String msg, context) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: main_cubit.get(context).light
          ? Theme.of(context).cardColor
          : Theme.of(context).primaryColor,
      textColor: main_cubit.get(context).light
          ? Theme.of(context).primaryColor
          : Theme.of(context).cardColor,
      fontSize: 16.0);
}

Future<bool?> toastbuilder2(
  String msg,
) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}

//Widget SPLASHSCREEN(Widget Next, context) {
//  return Scaffold(
//    body: EasySplashScreen(
//      logo: const Image(
//        image: AssetImage('lib/assets/images/appstore.png'),
//      ),
//      logoSize: 60,
//      loaderColor: Color.fromRGBO(221, 223, 201, 1),
//      backgroundColor: Color.fromARGB(255, 18, 18, 19),
//      showLoader: true,
//      loadingText: Text(
//        main_cubit.get(context).isArabic ? 'جاري التحميل ..' : 'Loading .. ',
//        textDirection: main_cubit.get(context).isArabic
//            ? TextDirection.rtl
//            : TextDirection.ltr,
//        style: TextStyle(
//          fontFamily: main_cubit.get(context).isArabic
//              ? 'Tajawal'
//              : 'Opificio_Bold_rounded',
//        ),
//      ),
//      navigator: Directionality(
//          textDirection: main_cubit.get(context).isArabic
//              ? TextDirection.rtl
//              : TextDirection.ltr,
//          child: Next),
//      durationInSeconds: 5,
//    ),
//  );
//}

Widget postbuilder(context, PostModel? model, String postId, int index) => Card(
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('${model?.profilephoto}')),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  width: 205,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          textstyle(
                              context: context,
                              arabicText: '${model?.name}',
                              englishText: '${model?.name}',
                              fontsize: 14,
                              TextAlign: TextAlign.start,
                              color: Colors.black),
                          const SizedBox(
                            width: 3,
                          ),
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
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${model?.postDateTime?.toDate()}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: textstyle(
                  maxline: (model!.postText!.length),
                  context: context,
                  arabicText: '${model.postText}',
                  englishText: '${model.postText}',
                  fontsize: 15,
                  TextAlign: TextAlign.start,
                  color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          if (model.postImage != null)
            Center(child: postCachedImage('${model.postImage}', context)),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            social_cubit_home.get(context).userputlike?[postId]
                                            ?['$Uid'] ==
                                        false ||
                                    social_cubit_home
                                            .get(context)
                                            .userputlike?[postId]?['$Uid'] ==
                                        null
                                ? const Icon(
                                    IconlyBroken.heart,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    IconlyBold.heart,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${social_cubit_home.get(context).likes[postId] ?? 0}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        social_cubit_home.get(context).userputlike?[postId]
                                        ?[Uid] ==
                                    false ||
                                social_cubit_home
                                        .get(context)
                                        .userputlike?[postId]?[Uid] ==
                                    null
                            ? social_cubit_home.get(context).addlike(postId)
                            : social_cubit_home.get(context).removelike(postId);
                      },
                    ),
                    InkWell(
                      onTap: () async {
                        social_cubit_home.get(context).postId = '${postId}';
                        social_cubit_home.get(context).getcomments('${postId}');

                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => comments()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconlyBroken.chat,
                                size: 30,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${social_cubit_home.get(context).comments[postId] ?? 0} comments',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage('${model.profilephoto}')),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 10, top: 10, bottom: 10, end: 135),
                          child: Text(
                            'Write a comment ...',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        onTap: () async {
                          social_cubit_home.get(context).postId = '${postId}';
                          social_cubit_home
                              .get(context)
                              .getcomments('${postId}');

                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => comments()));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget userspostbuilder(context, PostModel? model, String postId, int index) =>
    Card(
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('${model?.profilephoto}')),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  width: 205,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          textstyle(
                              context: context,
                              arabicText: '${model?.name}',
                              englishText: '${model?.name}',
                              fontsize: 14,
                              TextAlign: TextAlign.start,
                              color: Colors.black),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${model?.postDateTime?.toDate()}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: textstyle(
                  maxline: (model!.postText!.length),
                  context: context,
                  arabicText: '${model.postText}',
                  englishText: '${model.postText}',
                  fontsize: 15,
                  TextAlign: TextAlign.start,
                  color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          if (model.postImage != null)
            Center(child: postCachedImage('${model.postImage}', context)),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            social_cubit_home.get(context).userputlike?[postId]
                                            ?['$Uid'] ==
                                        false ||
                                    social_cubit_home
                                            .get(context)
                                            .userputlike?[postId]?['$Uid'] ==
                                        null
                                ? const Icon(
                                    IconlyBroken.heart,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    IconlyBold.heart,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${social_cubit_home.get(context).likes[postId] ?? 0}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        social_cubit_home.get(context).userputlike?[postId]
                                        ?[Uid] ==
                                    false ||
                                social_cubit_home
                                        .get(context)
                                        .userputlike?[postId]?[Uid] ==
                                    null
                            ? social_cubit_home.get(context).addlike(postId)
                            : social_cubit_home.get(context).removelike(postId);
                      },
                    ),
                    InkWell(
                      onTap: () async {
                        social_cubit_home.get(context).postId = '${postId}';
                        social_cubit_home.get(context).getcomments('${postId}');

                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => comments()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconlyBroken.chat,
                                size: 30,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${social_cubit_home.get(context).comments[postId] ?? 0} comments',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage('${model.profilephoto}')),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 10, top: 10, bottom: 10, end: 135),
                          child: Text(
                            'Write a comment ...',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        onTap: () async {
                          social_cubit_home.get(context).postId = '${postId}';
                          social_cubit_home
                              .get(context)
                              .getcomments('${postId}');

                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => comments()));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget Addpostbuilder(
        context, usermodel? model, TextEditingController controller) =>
    SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage('${model?.profilephoto}')),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 215,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    textstyle(
                                        context: context,
                                        arabicText: '${model?.name}',
                                        englishText: '${model?.name}',
                                        fontsize: 15,
                                        TextAlign: TextAlign.start,
                                        color: Colors.black),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    if (FirebaseAuth.instance.currentUser
                                            ?.emailVerified ==
                                        true)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.blue,
                                        size: 16,
                                      )
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                divider2(context),
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 100,
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: main_cubit.get(context).isArabic
                              ? 'بم تفكر ؟؟'
                              : 'What\'s on your mind..',
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                if (social_cubit_home.get(context).postimage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: FileImage(
                                    social_cubit_home.get(context).postimage!),
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          social_cubit_home.get(context).deletePostImage();
                        },
                      )
                    ],
                  ),
                InkWell(
                  onTap: () {
                    social_cubit_home.get(context).getpostimage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(20)),
                      height: 50,
                      width: 200,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              IconlyBroken.image,
                              size: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            textstyle(
                                maxline: 2,
                                context: context,
                                arabicText: 'اضافة صورة',
                                englishText: 'Add Photo',
                                fontsize: 23,
                                TextAlign: TextAlign.center,
                                color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget commentBuilder(
  context,
  comment_model? model,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CircleAvatar(
          radius: 20, backgroundImage: NetworkImage('${model?.profilephoto}')),
      const SizedBox(
        width: 10,
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.deepOrange, borderRadius: BorderRadius.circular(20)),
        constraints: BoxConstraints(
          maxHeight: double.infinity,
          maxWidth: MediaQuery.of(context).size.width / 1.3,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textstyle(
                  context: context,
                  arabicText: '${model?.name}',
                  englishText: '${model?.name}',
                  fontsize: 18,
                  TextAlign: TextAlign.start,
                  color: Colors.white),
              textstyle(
                  maxline: 10,
                  context: context,
                  arabicText: '${model?.commentText}',
                  englishText: '${model?.commentText}',
                  fontsize: 20,
                  TextAlign: TextAlign.start,
                  color: Colors.white),
            ],
          ),
        ),
      )
    ]),
  );
}

Widget chatusersbuilder(
  context,
  friendsmodel? model,
) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          social_cubit_home.get(context).messageList = [];
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => chat_Screen(model)));
        },
        child: Container(
          height: 50,
          width: double.infinity,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('${model?.profileimage}')),
            const SizedBox(
              width: 15,
            ),
            Container(
              width: 215,
              child: Row(
                children: [
                  textstyle(
                      context: context,
                      arabicText: '${model?.name}',
                      englishText: '${model?.name}',
                      fontsize: 15,
                      TextAlign: TextAlign.start,
                      color: Colors.black),
                  const SizedBox(
                    width: 3,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );

Widget usersbuilder(
  context,
  usermodel? model,
) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => profileusers(model)));
                social_cubit_home
                    .get(context)
                    .getallusersPosts('${model?.uid}');
                social_cubit_home
                    .get(context)
                    .getallusersfriendsnum('${model?.uid}');
              },
              child: Container(
                height: 50,
                width: double.infinity,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              '${model?.profilephoto}',
                              scale: 0.1)),
                      const SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          textstyle(
                              context: context,
                              arabicText: '${model?.name}',
                              englishText: '${model?.name}',
                              fontsize: 15,
                              TextAlign: TextAlign.start,
                              color: Colors.black),
                          const SizedBox(
                            width: 3,
                          ),
                          if (model?.isEmailVerified == true)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          if (social_cubit_home.get(context).myfriendsid.contains(model?.uid))
            Expanded(
                child: Column(
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
            )),
        ],
      ),
    );

Widget userprofilebuilder(context, usermodel? model) {
  return Column(children: [
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
                backgroundImage: NetworkImage('${model?.profilephoto}'),
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
    SingleChildScrollView(
      child: const SizedBox(
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
                    '${model?.posts ?? 0}',
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
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Text(
                    '10k',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    'Followers',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Text(
                    '500',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    'Following',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ]);
}

Widget buildMyMassage(
  context,
  massage_model? model,
) {
  return model?.image == null
      ? SwipeTo(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(15),
                      topEnd: Radius.circular(15),
                      topStart: Radius.circular(15),
                    )),
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                  maxWidth: MediaQuery.of(context).size.width / 1.3,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (model?.replayedmassageText != null)
                        textstyle(
                            maxline: 10,
                            context: context,
                            arabicText: '${model?.replayedmassageText}',
                            englishText: '${model?.replayedmassageText}',
                            fontsize: 22,
                            TextAlign: TextAlign.start,
                            color: Colors.black45),
                      textstyle(
                          maxline: 10,
                          context: context,
                          arabicText: '${model?.massageText}',
                          englishText: '${model?.massageText}',
                          fontsize: 20,
                          TextAlign: TextAlign.start,
                          color: Colors.white)
                    ],
                  ),
                )),
          ),
          onLeftSwipe: () {
            social_cubit_home.get(context).replayedmessage =
                '${model?.massageText}';
            social_cubit_home
                .get(context)
                .open_bottom_sheet(context, model?.receiverId, model?.token);
            social_cubit_home.get(context).replay = true;
            social_cubit_home.get(context).sendreplaymessages();
          },
        )
      : Align(
          alignment: Alignment.bottomRight,
          child: messageCachedImage('${model?.image}'));
}

Widget buildReseiverMassage(context, massage_model? model) {
  return model?.image == null
      ? SwipeTo(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(15),
                      topEnd: Radius.circular(15),
                      topStart: Radius.circular(15),
                    )),
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                  maxWidth: MediaQuery.of(context).size.width / 1.3,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (model?.replayedmassageText != null)
                        textstyle(
                            maxline: 10,
                            context: context,
                            arabicText: '${model?.replayedmassageText}',
                            englishText: '${model?.replayedmassageText}',
                            fontsize: 22,
                            TextAlign: TextAlign.start,
                            color: Colors.deepOrange),
                      textstyle(
                          maxline: 10,
                          context: context,
                          arabicText: '${model?.massageText}',
                          englishText: '${model?.massageText}',
                          fontsize: 20,
                          TextAlign: TextAlign.start,
                          color: Colors.white)
                    ],
                  ),
                )),
          ),
          onRightSwipe: () {
            social_cubit_home.get(context).replayedmessage =
                '${model?.massageText}';
            social_cubit_home
                .get(context)
                .open_bottom_sheet(context, model?.senderId, model?.token);
            social_cubit_home.get(context).replay = true;
          })
      : Align(
          alignment: Alignment.bottomLeft,
          child: messageCachedImage('${model?.image}'));
}

Widget messageCachedImage(String url) {
  return Container(
    constraints: const BoxConstraints(
      maxHeight: 250,
      maxWidth: 250,
    ),
    child: Center(
      child: CachedNetworkImage(
        imageUrl: '${url}',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(
          value: downloadProgress.progress,
          color: Colors.deepOrange,
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          color: Colors.deepOrange,
        ),
      ),
    ),
  );
}

Widget profileimageCachedImage(String url) {
  return CachedNetworkImage(
    imageUrl: '${url}',
    imageBuilder: (context, imageProvider) => CircleAvatar(
      radius: 55,
      backgroundColor: Colors.white,
      child: Container(
        height: 100,
        width: 100,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            '${url}',
          ),
        ),
      ),
    ),
    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
        color: Colors.deepOrange,
      ),
    ),
    errorWidget: (context, url, error) => Center(
      child: const Icon(
        Icons.error,
        color: Colors.deepOrange,
      ),
    ),
  );
}

Widget coverimageCachedImage(String url) {
  return CachedNetworkImage(
    imageUrl: '${url}',
    imageBuilder: (context, imageProvider) => Card(
      margin: EdgeInsets.zero,
      child: Image(
        image: NetworkImage(url),
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: 170,
      ),
    ),
    errorWidget: (context, url, error) => Center(
      child: const Icon(
        Icons.error,
        color: Colors.deepOrange,
      ),
    ),
  );
}

Widget postCachedImage(String url, context) {
  return Container(
    alignment: Alignment.center,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height / 2,
      maxWidth: MediaQuery.of(context).size.width / 1.1,
    ),
    child: CachedNetworkImage(
      imageUrl: '$url',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(
        value: downloadProgress.progress,
        color: Colors.deepOrange,
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.deepOrange,
      ),
    ),
  );
}

Widget notificationsbuilder(notifications_model? model, context, int? index) {
  return model?.friendsRequest == false
      ? Card(
          margin: const EdgeInsets.all(10),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage('${model?.senderprofileimage}')),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: textstyle(
                                maxline: 2,
                                context: context,
                                arabicText: '${model?.title}',
                                englishText: '${model?.title}',
                                fontsize: 15,
                                TextAlign: TextAlign.start,
                                color: Colors.deepOrange)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if ('${model?.body}' != '')
                      Container(
                          width: 400,
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                          ),
                          child: textstyle(
                              context: context,
                              arabicText: '${model?.body}',
                              englishText: '${model?.body}',
                              fontsize: 18,
                              TextAlign: TextAlign.start,
                              color: Colors.black,
                              maxline: 2)),
                  ]),
            ),
          ),
        )
      : Card(
          margin: const EdgeInsets.all(10),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage('${model?.senderprofileimage}')),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: textstyle(
                                maxline: 2,
                                context: context,
                                arabicText: '${model?.title}',
                                englishText: '${model?.title}',
                                fontsize: 15,
                                TextAlign: TextAlign.start,
                                color: Colors.deepOrange)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if ('${model?.body}' != '')
                      Container(
                          width: 400,
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                          ),
                          child: textstyle(
                              context: context,
                              arabicText: '${model?.body}',
                              englishText: '${model?.body}',
                              fontsize: 18,
                              TextAlign: TextAlign.start,
                              color: Colors.black,
                              maxline: 2)),
                    Row(
                      children: [
                        textbutton(
                            buttontextArabic: 'اضافة',
                            buttontextEnglish: " Add ",
                            Color: Colors.deepOrange,
                            context: context,
                            function: () {
                              social_cubit_home.get(context).addFriends(
                                  myfriendname: '${model?.sendername}',
                                  myfrienduid: '${model?.senderuid}',
                                  myfriendprofileimage:
                                      '${model?.senderprofileimage}',
                                  token: '${model?.token}');
                              social_cubit_home
                                  .get(context)
                                  .deleteFriendsRequest(
                                      '${model?.receiveruid}');
                            }),
                        textbutton(
                            buttontextArabic: 'رفض الطلب',
                            buttontextEnglish: " Delete ",
                            Color: Colors.deepOrange,
                            context: context,
                            function: () {
                              social_cubit_home
                                  .get(context)
                                  .Notificationslist
                                  .removeAt(index!);
                            }),
                      ],
                    )
                  ]),
            ),
          ),
        );
}

Widget replaymessage(context, String? lastmessage, String? replayed) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
        decoration: const BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(15),
              topEnd: Radius.circular(15),
              topStart: Radius.circular(15),
            )),
        constraints: BoxConstraints(
          maxHeight: double.infinity,
          maxWidth: MediaQuery.of(context).size.width / 1.3,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              textstyle(
                  maxline: 2,
                  context: context,
                  arabicText: '${lastmessage}',
                  englishText: '${lastmessage}',
                  fontsize: 22,
                  TextAlign: TextAlign.start,
                  color: Colors.white),
              textstyle(
                  maxline: 10,
                  context: context,
                  arabicText: '${replayed}',
                  englishText: '${replayed}',
                  fontsize: 20,
                  TextAlign: TextAlign.start,
                  color: Colors.white)
            ],
          ),
        )),
  );
}

//layInputBottomSheet(bool isRightSwipe, context, String? lastmessage) {
//lBottomSheet(
//t: context,
//r: (context) {
//rn Padding(
//dding: MediaQuery.of(context).viewInsets,
//ild: Container(
//padding: const EdgeInsets.only(
//  left: 16.0,
//  right: 16.0,
//  top: 16.0,
//  bottom: 16.0,
//),
//child: TextField(
//  autofocus: true,
//  textInputAction: TextInputAction.done,
//  textCapitalization: TextCapitalization.words,
//  onSubmitted: (value) {
//    replaymessage(context, lastmessage, value);
//    social_cubit_home.get(context).replayed = true;
//  },
//  decoration: const InputDecoration(
//    labelText: 'Reply',
//    hintText: 'enter reply here',
//    border: OutlineInputBorder(
//      borderRadius: BorderRadius.all(
//        Radius.circular(
//          5.0,
//        ),
//      ),
//    ),
//  ),
//),
//
//      );
//    },
//  );
//}
