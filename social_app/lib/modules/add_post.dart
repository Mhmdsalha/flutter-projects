import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/modules/home_screen.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/Adaptive.dart';
import 'package:shop/styles/textstyle.dart';

class addPost_screen extends StatelessWidget {
  var posttext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<social_cubit_home, social_app_states>(
      listener: (context, state) {
        if (state is createPostSuccess) {
          social_cubit_home.get(context).currentindex(0);
          social_cubit_home.get(context).usermodel_object = null;
          social_cubit_home.get(context).postsId = [];
          social_cubit_home.get(context).getPosts();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => home_screen()),
              (Route<dynamic> route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(IconlyBroken.arrow_left),
                onPressed: () {
                  social_cubit_home.get(context).usermodel_object = null;
                  social_cubit_home.get(context).getPosts();
                  social_cubit_home.get(context).myfriendspostsList.clear();
                  social_cubit_home.get(context).currentindex(0);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => home_screen()),
                      (Route<dynamic> route) => false);
                },
              ),
              title: textstyle(
                  context: context,
                  arabicText: 'اضافة منشور جديد',
                  englishText: 'Cerate Post',
                  fontsize: 25,
                  TextAlign: TextAlign.start,
                  color: Colors.deepOrange),
              actions: [
                textbutton(
                    size: 20,
                    buttontextArabic: 'نشر',
                    buttontextEnglish: 'Post',
                    Color: Colors.deepOrange,
                    context: context,
                    function: () {
                      social_cubit_home.get(context).postimage == null
                          ? social_cubit_home.get(context).CreatePost(
                              context: context, postText: posttext.text)
                          : social_cubit_home.get(context).UplodePost(
                              context: context, postText: posttext.text);
                      social_cubit_home
                          .get(context)
                          .myfriendspostsListid
                          .clear();
                      social_cubit_home.get(context).getPosts();
                    })
              ],
            ),
            body: social_cubit_home.get(context).usermodel_object == null
                ? Center(child: adaptive(os: getos()))
                : Stack(
                    children: [
                      Addpostbuilder(
                          context,
                          social_cubit_home.get(context).usermodel_object,
                          posttext),
                      if (state is createPostloading ||
                          state is uploadPostimagestate_loading)
                        Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Color.fromARGB(61, 255, 255, 255),
                            child: Center(child: adaptive(os: getos())))
                    ],
                  ));
      },
    );
  }
}
