import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/models/friendsmodel.dart';
import 'package:shop/models/massage_model.dart';
import 'package:shop/models/usermodel.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/textstyle.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/layout/main_cubit.dart';

class chat_Screen extends StatelessWidget {
  friendsmodel? model;

  chat_Screen(this.model);

  var chattext = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        social_cubit_home.get(context).getmessages('${model?.uid}');

        return BlocConsumer<social_cubit_home, social_app_states>(
          listener: (context, state) {
            if (state is sendMassage_success) {
              chattext.text = '';
              social_cubit_home.get(context).replay = false;
              if (social_cubit_home.get(context).messageimage != null) {
                social_cubit_home.get(context).deletemessageimage();
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                    title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage('${model?.profileimage}')),
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
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ])),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        social_cubit_home.get(context).messageList.isNotEmpty
                            ? Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: chatBuilderScreen(context)))
                            : Expanded(
                                child: Center(
                                    child: textstyle(
                                        context: context,
                                        arabicText: 'لا يوجد رسائل',
                                        englishText: 'No messages yet',
                                        fontsize: 20,
                                        TextAlign: TextAlign.center,
                                        color: Colors.deepOrange))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (social_cubit_home.get(context).messageimage !=
                                null)
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    bottom: 20, end: 10),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: FileImage(social_cubit_home
                                                  .get(context)
                                                  .messageimage!),
                                              fit: BoxFit.cover)),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                        color: Colors.deepOrange,
                                      ),
                                      onPressed: () {
                                        social_cubit_home
                                            .get(context)
                                            .deletemessageimage();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          if (social_cubit_home
                                                  .get(context)
                                                  .messageimage ==
                                              null) {
                                            return 'Cannot send empty message';
                                          } else {
                                            return null;
                                          }
                                        }
                                        KeyboardLockMode;
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      controller: chattext,
                                      textDirection:
                                          main_cubit.get(context).isArabic
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            main_cubit.get(context).isArabic
                                                ? 'Tajawal'
                                                : 'Opificio_Bold_rounded',
                                      ),
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.deepOrange,
                                                width: 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.deepOrange,
                                                width: 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                          ),
                                          hintText: 'Massage',
                                          fillColor: Colors.deepOrange,
                                          filled: true,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                                topEnd: Radius.circular(15),
                                                bottomEnd:
                                                    Radius.circular(15))),
                                    child: Row(
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            social_cubit_home
                                                .get(context)
                                                .getmessageimage();
                                          },
                                          minWidth: 1,
                                          child: const Icon(
                                            IconlyBroken.image,
                                            size: 20,
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              KeyboardLockMode;
                                              social_cubit_home
                                                          .get(context)
                                                          .messageimage ==
                                                      null
                                                  ? social_cubit_home
                                                      .get(context)
                                                      .sendMassage(
                                                        receiverId:
                                                            '${model?.uid}',
                                                        token:
                                                            '${model?.token}',
                                                        massageText:
                                                            chattext.text,
                                                      )
                                                  : social_cubit_home
                                                      .get(context)
                                                      .Uplodemessage(
                                                          context: context,
                                                          receiverId:
                                                              '${model?.uid}',
                                                          token:
                                                              '${model?.token}');
                                            }
                                            ;
                                          },
                                          minWidth: 1,
                                          child: const Icon(
                                            IconlyBroken.send,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}
