import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/layout/social_cubit_login.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/modules/Register_screen.dart';
import 'package:shop/modules/home_screen.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/Adaptive.dart';
import 'package:shop/styles/textstyle.dart';
import 'package:shop/layout/social_cubit_register.dart';

class login_screen extends StatelessWidget {
  @override
  var emailtext = TextEditingController();

  var passwordtext = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => social_cubit_login(),
        child: BlocConsumer<social_cubit_login, social_app_states>(
            listener: (context, state) {
          if (state is error_login_state) {
            toastbuilder(
                main_cubit.get(context).isArabic
                    ? 'يرجى التحقق من البيانات المدخلة '
                    : 'Please check the information you entered',
                context);
          }
          if (state is login_success) {
            cache_helper.savedata(key: 'Uid', value: state.Uid).then((value) {
              Uid = state.Uid;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => home_screen()),
                  (Route<dynamic> route) => false);
              social_cubit_home.get(context).currentindex(0);
              social_cubit_home.get(context).usermodel_object = null;
              social_cubit_home.get(context).myfriendspostsList = [];
            });
          }
        }, builder: (context, state) {
          return Scaffold(
              body: Center(
            child: SingleChildScrollView(
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
                        Image(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width / 1.1,
                            image: const AssetImage(
                                'lib/assets/images/5098290.png')),
                        const SizedBox(
                          height: 10,
                        ),
                        textstyle(
                          context: context,
                          arabicText: 'تسجيل الدخول',
                          englishText: 'Sign In',
                          fontsize: 30,
                          TextAlign: TextAlign.center,
                          color: main_cubit.get(context).light
                              ? Colors.black
                              : Colors.white,
                        ),
                        Directionality(
                            textDirection: TextDirection.ltr,
                            child: Column(children: [
                              defultTextfield(
                                EdgeInsetsGeometry:
                                    const EdgeInsetsDirectional.only(
                                  top: 20,
                                ),
                                width: MediaQuery.of(context).size.width / 1.1,
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
                                EdgeInsetsGeometry: EdgeInsetsDirectional.only(
                                  top: 20,
                                ),
                                width: MediaQuery.of(context).size.width / 1.1,
                                controller: passwordtext,
                                keyboardType: TextInputType.text,
                                labelText: 'Password',
                                prefixIcon: Icons.lock,
                                context: context,
                                suffixIconpressed: () {
                                  social_cubit_login
                                      .get(context)
                                      .suffixIconpressed();
                                },
                                suffixIcon:
                                    social_cubit_login.get(context).isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                isPassword:
                                    social_cubit_login.get(context).isObscure,
                                validator: (value) {
                                  if (value == "") {
                                    return 'Enter your Password';
                                  }
                                  return null;
                                },
                              ),
                            ])),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: state is login_loading
                              ? Container(
                                  margin:
                                      const EdgeInsetsDirectional.only(top: 10),
                                  child: Center(child: adaptive(os: getos())))
                              : defultbutton(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  context: context,
                                  Color: Colors.deepOrange,
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      social_cubit_login.get(context).userlogin(
                                          email: emailtext.text,
                                          password: passwordtext.text);
                                    }
                                  },
                                  buttontextArabic: ' تسجيل الدخول',
                                  buttontextEnglish: 'Sign In'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textstyle(
                              context: context,
                              arabicText: ' لا تمتلك حساب ؟',
                              englishText: 'Don\'t have an account ?',
                              fontsize: 15,
                              TextAlign: TextAlign.center,
                              color: main_cubit.get(context).light
                                  ? Color.fromRGBO(97, 97, 97, 1)
                                  : Colors.grey,
                            ),
                            textbutton(
                                size: 15,
                                context: context,
                                buttontextArabic: 'إنشاء حساب',
                                buttontextEnglish: 'Sign up',
                                Color: Colors.deepOrange,
                                function: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Register_screen()),
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
                                  await social_cubit_login
                                      .get(context)
                                      .SignIn(context);
                                },
                                child: defultbuttonwithicon(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    Color: Colors.red,
                                    Color2: Colors.black,
                                    function: () {},
                                    buttontextEnglish: 'Continue with Google',
                                    context: context,
                                    icon: Bootstrap.google),
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
          ));
        }));
  }
}
