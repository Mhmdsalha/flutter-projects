import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/shop_cubit.login.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/modules/Register_screen.dart';
import 'package:shop/modules/shop_screen.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/Adaptive.dart';

class login_screen extends StatelessWidget {
  @override
  var emailtext = TextEditingController();

  var passwordtext = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => shop_cubit_login(),
        child: BlocConsumer<shop_cubit_login, shop_states>(
          listener: (context, state) {
            if (state is login_success) {
              if (state.loginsuccess.status == true) {
                cache_helper
                    .savedata(key: 'name', value: state.loginsuccess.data?.name)
                    .then((value) {
                  name = state.loginsuccess.data!.name;
                });

                cache_helper
                    .savedata(
                        key: 'token', value: state.loginsuccess.data?.token)
                    .then((value) {
                  token = state.loginsuccess.data!.token!;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => home_screen()),
                      (Route<dynamic> route) => false);
                  shop_cubit_home.get(context).profile_model_object = null;
                  shop_cubit_home.get(context).home_model_object = null;
                  shop_cubit_home.get(context).gethomedata();
                  shop_cubit_home.get(context).get_profile_data();
                });
                toastbuilder(state.loginsuccess.message, context);
              } else {
                toastbuilder(state.loginsuccess.message, context);
              }
            }
          },
          builder: (context, state) {
            var cubitLogin = shop_cubit_login.get(context);
            var cubit = shop_cubit_home.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(10),
                    child: Form(
                      key: formkey,
                      child: Directionality(
                        textDirection: main_cubit.get(context).isArabic
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text(
                              main_cubit.get(context).isArabic
                                  ? 'تسجيل الدخول'
                                  : 'Login',
                              textDirection: main_cubit.get(context).isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 40,
                                fontFamily: main_cubit.get(context).isArabic
                                    ? 'Tajawal'
                                    : 'Opificio_Bold_rounded',
                              ),
                            )),
                            defultTextfield(
                              context: context,
                              textdirection: TextDirection.ltr,
                              validator: (value) {
                                if (value == "") {
                                  return 'Enter your Email Address';
                                }
                                return null;
                              },
                              controller: emailtext,
                              keyboardType: TextInputType.emailAddress,
                              labelText: main_cubit.get(context).isArabic
                                  ? 'البريد الإلكتروني'
                                  : 'Email Address',
                              prefixIcon: Icons.email,
                              Color: main_cubit.get(context).light
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).cardColor,
                            ),
                            defultTextfield(
                                context: context,
                                textdirection: TextDirection.ltr,
                                validator: (value) {
                                  if (value == "") {
                                    return 'Enter your Password';
                                  }
                                  return null;
                                },
                                controller: passwordtext,
                                onSubmitted: (String) {
                                  if (formkey.currentState!.validate()) {
                                    KeyboardLockMode;
                                  }
                                },
                                keyboardType: TextInputType.visiblePassword,
                                labelText: main_cubit.get(context).isArabic
                                    ? 'كلمة المرور'
                                    : 'Password',
                                prefixIcon: Icons.lock,
                                suffixIcon: cubitLogin.isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                isPassword: cubitLogin.isObscure,
                                suffixIconpressed: () {
                                  cubitLogin.suffixIconpressed();
                                },
                                Color: main_cubit.get(context).light
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).cardColor),
                            const SizedBox(
                              height: 10,
                            ),
                            state is login_loading == true
                                ? Center(
                                    child: Center(child: adaptive(os: getos())),
                                  )
                                : Center(
                                    child: defultbutton(
                                        context: context,
                                        width: 250,
                                        Color: main_cubit.get(context).light
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).cardColor,
                                        buttontext:
                                            main_cubit.get(context).isArabic
                                                ? 'تسجيل الدخول'
                                                : 'Login',
                                        function: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            cubit.currentindex(0);
                                            cubitLogin.userlogin(
                                                email: emailtext.text,
                                                password: passwordtext.text);
                                          }
                                        }),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                    top: 15,
                                  ),
                                  child: Text(
                                    main_cubit.get(context).isArabic
                                        ? 'لا تمتلك حساب ؟'
                                        : 'Don\'t you have an account ? ',
                                    style: TextStyle(
                                      fontFamily:
                                          main_cubit.get(context).isArabic
                                              ? 'Tajawal'
                                              : 'Opificio_Bold_rounded',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                textbutton(
                                    context: context,
                                    text: main_cubit.get(context).isArabic
                                        ? 'سجل الان'
                                        : 'Register Now',
                                    Color: main_cubit.get(context).light
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).cardColor,
                                    function: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register_screen()),
                                          (Route<dynamic> route) => false);
                                    })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
