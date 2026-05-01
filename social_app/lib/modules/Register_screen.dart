import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_register.dart';
import 'package:shop/models/usermodel.dart';
import 'package:shop/modules/home_screen.dart';
import 'package:shop/modules/login.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/styles/Adaptive.dart';
import 'package:shop/styles/textstyle.dart';
import 'package:shop/layout/social_cubit_home.dart';

class Register_screen extends StatelessWidget {
  var emailtext = TextEditingController();
  var passwordtext = TextEditingController();
  var nametext = TextEditingController();
  var phonetext = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => social_cubit_Register(),
        child: BlocConsumer<social_cubit_Register, social_app_states>(
          listener: (context, state) {
            if (state is error_createuser_state) {
              toastbuilder(
                  main_cubit.get(context).isArabic
                      ? 'يرجى التحقق من البيانات المدخلة '
                      : 'Please check the information you entered',
                  context);
            }
            if (state is createuser_success) {
              cache_helper.savedata(key: 'Uid', value: state.Uid).then((value) {
                social_cubit_home.get(context).currentindex(0);
                social_cubit_home.get(context).usermodel_object = null;
                social_cubit_home.get(context).myfriendspostsList = [];
                Uid = state.Uid;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => home_screen()),
                    (Route<dynamic> route) => false);
              });
              cache_helper.savedata(key: 'token', value: state.token);
              Token = state.token;
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: formkey,
                    child: Directionality(
                      textDirection: main_cubit.get(context).isArabic
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textstyle(
                            context: context,
                            arabicText: 'إنشاء حساب',
                            englishText: 'Create an Account',
                            fontsize: 30,
                            TextAlign: TextAlign.center,
                            color: main_cubit.get(context).light
                                ? Colors.black
                                : Colors.white,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Directionality(
                              textDirection: TextDirection.ltr,
                              child: Column(children: [
                                defultTextfield(
                                  EdgeInsetsGeometry:
                                      EdgeInsetsDirectional.only(
                                    top: 20,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  controller: emailtext,
                                  keyboardType: TextInputType.emailAddress,
                                  labelText: 'Email Address',
                                  prefixIcon: Icons.email,
                                  context: context,
                                  validator: (value) {
                                    if (value == "") {
                                      return 'Enter your Email Address';
                                    }
                                    return null;
                                  },
                                ),
                                defultTextfield(
                                  EdgeInsetsGeometry:
                                      EdgeInsetsDirectional.only(
                                    top: 20,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  controller: nametext,
                                  keyboardType: TextInputType.text,
                                  labelText: 'Full Name',
                                  prefixIcon: Icons.person,
                                  context: context,
                                  validator: (value) {
                                    if (value == "") {
                                      return 'Enter your full name';
                                    }
                                    return null;
                                  },
                                ),
                                defultTextfield(
                                  EdgeInsetsGeometry:
                                      EdgeInsetsDirectional.only(
                                    top: 20,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  controller: passwordtext,
                                  keyboardType: TextInputType.text,
                                  labelText: 'Password',
                                  prefixIcon: Icons.lock,
                                  context: context,
                                  suffixIconpressed: () {
                                    social_cubit_Register
                                        .get(context)
                                        .suffixIconpressed();
                                  },
                                  suffixIcon: social_cubit_Register
                                          .get(context)
                                          .isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  isPassword: social_cubit_Register
                                      .get(context)
                                      .isObscure,
                                  validator: (value) {
                                    if (value == "") {
                                      return 'Enter your Password';
                                    }
                                    return null;
                                  },
                                ),
                                defultTextfield(
                                  EdgeInsetsGeometry:
                                      EdgeInsetsDirectional.only(
                                    top: 20,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  controller: phonetext,
                                  keyboardType: TextInputType.phone,
                                  labelText: 'Phone',
                                  prefixIcon: Icons.phone,
                                  context: context,
                                  validator: (value) {
                                    if (value == "") {
                                      return 'Enter your Phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ])),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: state is register_loading
                                  ? Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          top: 10),
                                      child:
                                          Center(child: adaptive(os: getos())))
                                  : defultbutton(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      context: context,
                                      Color: Colors.deepOrange,
                                      function: () {
                                        if (formkey.currentState!.validate()) {
                                          social_cubit_Register
                                              .get(context)
                                              .userRegister(
                                                  email: emailtext.text,
                                                  name: nametext.text,
                                                  phone: phonetext.text,
                                                  password: passwordtext.text);
                                        }
                                      },
                                      buttontextArabic: 'إنشاء حساب',
                                      buttontextEnglish: 'Create an Account')),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textstyle(
                                context: context,
                                arabicText: ' هل تمتلك حساب بالفعل ؟',
                                englishText: 'Already have an account ?',
                                fontsize: 15,
                                TextAlign: TextAlign.center,
                                color: main_cubit.get(context).light
                                    ? Color.fromRGBO(97, 97, 97, 1)
                                    : Colors.grey,
                              ),
                              textbutton(
                                  size: 15,
                                  context: context,
                                  buttontextArabic: 'تسجيل الدخول',
                                  buttontextEnglish: 'Sign in',
                                  Color: Colors.deepOrange,
                                  function: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                login_screen()),
                                        (Route<dynamic> route) => false);
                                  }),
                            ],
                          ),
                          divider(context),
                          const SizedBox(
                            height: 20,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await social_cubit_Register
                                        .get(context)
                                        .SignIn();
                                  },
                                  child: defultbuttonwithicon(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      Color: Colors.red,
                                      Color2: Colors.black,
                                      function: () {},
                                      buttontextEnglish: 'Continue with Google',
                                      context: context,
                                      icon: Bootstrap.google),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          )
                        ],
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
