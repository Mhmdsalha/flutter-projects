import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_cubit_Register.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/modules/login.dart';
import 'package:shop/modules/shop_screen.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/layout/main_cubit.dart';

import '../styles/Adaptive.dart';

class Register_screen extends StatelessWidget {
  var emailtext = TextEditingController();
  var passwordtext = TextEditingController();
  var nametext = TextEditingController();
  var phonetext = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => shop_cubit_Register(),
        child: BlocConsumer<shop_cubit_Register, shop_states>(
            listener: (context, state) {
          if (state is register_success) {
            if (state.registersuccess.status == true) {
              cache_helper
                  .savedata(
                      key: 'name', value: state.registersuccess.data?.name)
                  .then((value) {
                name = state.registersuccess.data!.name;
              });
              cache_helper
                  .savedata(
                      key: 'token', value: state.registersuccess.data?.token)
                  .then((value) {
                token = state.registersuccess.data!.token!;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => home_screen()),
                    (Route<dynamic> route) => false);
                shop_cubit_home.get(context).profile_model_object = null;
                shop_cubit_home.get(context).home_model_object = null;
                shop_cubit_home.get(context).gethomedata();
                shop_cubit_home.get(context).get_profile_data();
              });
              toastbuilder(state.registersuccess.message!, context);
            } else {
              toastbuilder(state.registersuccess.message!, context);
            }
          }
        }, builder: (context, state) {
          var cubit = shop_cubit_Register.get(context);
          var cubit2 = shop_cubit_home.get(context);
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
                                  ? 'إنشاء حساب'
                                  : 'Register',
                              textDirection: main_cubit.get(context).isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              style: TextStyle(
                                  fontFamily: main_cubit.get(context).isArabic
                                      ? 'Tajawal'
                                      : 'Opificio_Bold_rounded',
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: main_cubit.get(context).light
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor),
                            ),
                          ),
                          defultTextfield(
                            context: context,
                            textdirection: TextDirection.ltr,
                            validator: (value) {
                              if (value == "") {
                                return 'Enter your Full Name';
                              }
                              return null;
                            },
                            controller: nametext,
                            keyboardType: TextInputType.text,
                            labelText: main_cubit.get(context).isArabic
                                ? 'الاسم كامل'
                                : 'Full Name',
                            prefixIcon: Icons.person,
                            Color: main_cubit.get(context).light
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                          ),
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
                              suffixIcon: cubit.isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              isPassword: cubit.isObscure,
                              suffixIconpressed: () {
                                cubit.suffixIconpressed();
                              },
                              Color: main_cubit.get(context).light
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).cardColor),
                          defultTextfield(
                            context: context,
                            textdirection: TextDirection.ltr,
                            validator: (value) {
                              if (value == "") {
                                return 'Enter your Phone';
                              }
                              return null;
                            },
                            controller: phonetext,
                            keyboardType: TextInputType.number,
                            labelText: main_cubit.get(context).isArabic
                                ? 'رقم الهاتف'
                                : 'Phone Number',
                            prefixIcon: Icons.phone,
                            Color: main_cubit.get(context).light
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          state is register_loading == true
                              ? Center(child: adaptive(os: getos()))
                              : Center(
                                  child: defultbutton(
                                      context: context,
                                      width: 250,
                                      Color: main_cubit.get(context).light
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).cardColor,
                                      buttontext:
                                          main_cubit.get(context).isArabic
                                              ? 'إنشاء حساب'
                                              : 'Register',
                                      function: () {
                                        if (formkey.currentState!.validate()) {
                                          cubit2.currentindex(0);
                                          cubit.userRegister(
                                              email: emailtext.text,
                                              password: passwordtext.text,
                                              name: nametext.text,
                                              phone: phonetext.text);
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
                                      ? ' تمتلك حساب ؟'
                                      : ' You have an account ? ',
                                  style: TextStyle(
                                    fontFamily: main_cubit.get(context).isArabic
                                        ? 'Tajawal'
                                        : 'Opificio_Bold_rounded',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              textbutton(
                                  context: context,
                                  text: main_cubit.get(context).isArabic
                                      ? 'تسجيل الدخول'
                                      : 'Login',
                                  Color: main_cubit.get(context).light
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor,
                                  function: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                login_screen()),
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
        }));
  }
}
