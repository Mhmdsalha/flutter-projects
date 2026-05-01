import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/main_cubit.dart';

import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/Adaptive.dart';

class cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shop_cubit_home, shop_states>(
        listener: (context, state) {
      if (state is cart_success) {
        toastbuilder(state.cartsuccess.message, context);
      }
      state is change_cart_success
          ? Center(child: adaptive(os: getos()))
          : cart_screen(
              context: context,
              model: shop_cubit_home.get(context).cart_Screen_model_object!);
    }, builder: (context, state) {
      var total =
          shop_cubit_home.get(context).cart_Screen_model_object?.data!.subTotal;
      var cubit = shop_cubit_home.get(context);
      return Scaffold(
          appBar: AppBar(
              title: Container(
            alignment: main_cubit.get(context).isArabic
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            child: Text(
              main_cubit.get(context).isArabic
                  ? 'المجموع : ${total ?? '0'} '
                  : 'Total : ${total ?? '0'}',
              textDirection: main_cubit.get(context).isArabic
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              style: TextStyle(
                  fontFamily: main_cubit.get(context).isArabic
                      ? 'Tajawal'
                      : 'Opificio_Bold_rounded',
                  fontSize: 25),
            ),
          )),
          body: cubit.cart_Screen_model_object == null
              ? Center(child: adaptive(os: getos()))
              : cart_screen(
                  context: context,
                  model:
                      shop_cubit_home.get(context).cart_Screen_model_object!));
    });
  }
}
