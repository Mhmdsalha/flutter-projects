import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/modules/login.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/styles/textstyle.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/layout/social_cubit_home.dart';

class settings_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<social_cubit_home, social_app_states>(
      listener: (context, state) {
        if (state is sendEmailVerificationstate) {
          toastbuilder('Email Verification sent', context);
        }
      },
      builder: (context, state) {
        var model = social_cubit_home.get(context).usermodel_object;
        return Scaffold(
            appBar: AppBar(
              title: textstyle(
                  context: context,
                  arabicText: 'Settings',
                  englishText: 'Settings',
                  fontsize: 30,
                  TextAlign: TextAlign.center,
                  color: Colors.deepOrange),
            ),
            body: Center(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Directionality(
                textDirection: main_cubit.get(context).isArabic
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: main_cubit.get(context).light
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        textstyle(
                            context: context,
                            arabicText: 'التحقق من العنوان البريد الإلكتروني',
                            englishText: 'Email address verification',
                            fontsize: 20,
                            TextAlign: TextAlign.center,
                            color: Colors.deepOrange),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: main_cubit.get(context).light
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                            size: 25,
                          ),
                          onPressed: () {
                            if (FirebaseAuth
                                    .instance.currentUser?.emailVerified ==
                                false)
                              social_cubit_home
                                  .get(context)
                                  .Emailaddressverification();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: main_cubit.get(context).light
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        textstyle(
                            context: context,
                            arabicText: 'تغيير اللغة',
                            englishText: 'Change Language',
                            fontsize: 25,
                            TextAlign: TextAlign.center,
                            color: Colors.deepOrange),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: main_cubit.get(context).light
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                            size: 25,
                          ),
                          onPressed: () {
                            //main_cubit.get(context).isarabic();
                            //changelanguage(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.dark_mode_outlined,
                          color: main_cubit.get(context).light
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        textstyle(
                            context: context,
                            arabicText: 'الوضع الليلي',
                            englishText: 'Dark Mode',
                            fontsize: 25,
                            TextAlign: TextAlign.center,
                            color: Colors.deepOrange),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: main_cubit.get(context).light
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                            size: 25,
                          ),
                          onPressed: () {
                            //main_cubit.get(context).Islight();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: main_cubit.get(context).light
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        textstyle(
                            context: context,
                            arabicText: 'تسجيل الخروج',
                            englishText: 'Log Out',
                            fontsize: 25,
                            TextAlign: TextAlign.center,
                            color: Colors.deepOrange),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: main_cubit.get(context).light
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                            size: 25,
                          ),
                          onPressed: () {
                            cache_helper.removedata(key: 'Uid');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login_screen()),
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
      },
    );
  }
}
