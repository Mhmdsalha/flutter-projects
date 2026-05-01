import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/shered/components/constants.dart';

import '../styles/Adaptive.dart';

class favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shop_cubit_home, shop_states>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = shop_cubit_home.get(context);
          return Scaffold(
            body: Container(
                height: double.infinity,
                width: double.infinity,
                child:
                    shop_cubit_home.get(context).favorite_Screen_model_object ==
                            null
                        ? (state is! change_favorites_success
                            ? Container()
                            : Center(child: adaptive(os: getos())))
                        : favorites_screen(
                            context: context,
                            model: shop_cubit_home
                                .get(context)
                                .favorite_Screen_model_object!)),
          );
        });
  }
}
