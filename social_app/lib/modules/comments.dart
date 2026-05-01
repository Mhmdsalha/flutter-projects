import 'dart:math';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/styles/textstyle.dart';
import 'package:shop/layout/main_cubit.dart';

import 'home_screen.dart';

class comments extends StatelessWidget {
  var commentsdtext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<social_cubit_home, social_app_states>(
      listener: (context, state) {
        if (state is getcomments_success) {
          commentsdtext.text = '';
        }
      },
      builder: (context, state) {
        var model = social_cubit_home.get(context).usermodel_object;
        return Scaffold(
          appBar: AppBar(),
          body: Stack(alignment: Alignment.bottomCenter, children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: MediaQuery.of(context).size.height - 175,
                    child: commentBuilderScreen(context))),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                divider2(context),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: commentsdtext,
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
                            decoration: InputDecoration(
                              prefixIcon: const Icon(IconlyBroken.chat,
                                  size: 30, color: Colors.deepOrange),
                              hintText: 'Write a comment...',
                              fillColor: main_cubit.get(context).light
                                  ? Colors.black12
                                  : Colors.white12,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            social_cubit_home.get(context).CreateComment(
                                  commentText: commentsdtext.text,
                                  postId:
                                      '${social_cubit_home.get(context).postId}',
                                  context: context,
                                );
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.deepOrange,
                            size: 30,
                          ))
                    ],
                  ),
                )
              ],
            )
          ]),
        );
      },
    );
  }
}
