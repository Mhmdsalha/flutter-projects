import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_cubit_update_profile.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/Adaptive.dart';

class update_profile extends StatelessWidget {
  var emailtext = TextEditingController();
  var nametext = TextEditingController();
  var phonetext = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => shop_cubit_update_profile(),
        child: BlocConsumer<shop_cubit_update_profile, shop_states>(
            listener: (context, state) {
          if (state is update_success) {
            toastbuilder(state.updatesuccess.message!, context);
            shop_cubit_home.get(context).gethomedata();
            shop_cubit_home.get(context).get_profile_data();
            name = state.updatesuccess.data!.name;
            //shop_cubit_home.get(context).home_model_object = null;
            shop_cubit_home.get(context).profile_model_object = null;
          }
        }, builder: (context, state) {
          var cubit = shop_cubit_update_profile.get(context);
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
                                  ? 'تعديل معلومات الحساب'
                                  : 'Update Profile',
                              style: TextStyle(
                                  fontFamily: main_cubit.get(context).isArabic
                                      ? 'Tajawal'
                                      : 'Opificio_Bold_rounded',
                                  fontSize: 30,
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
                          if (state is! update_loading)
                            Center(
                              child: defultbutton(
                                  context: context,
                                  width: 250,
                                  Color: main_cubit.get(context).light
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor,
                                  buttontext: main_cubit.get(context).isArabic
                                      ? 'تعديل معلومات الحساب'
                                      : 'Update Profile',
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      cubit.updateuser(
                                          email: emailtext.text,
                                          name: nametext.text,
                                          phone: phonetext.text);

                                      cubit2.currentindex(0);
                                    }
                                  }),
                            )
                          else
                            Center(child: adaptive(os: getos())),
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
