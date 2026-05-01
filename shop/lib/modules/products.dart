import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';

import '../styles/Adaptive.dart';

class products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shop_cubit_home, shop_states>(
      listener: (context, state) {
        state is home_loading
            ? Center(
                child: CircularProgressIndicator(
                color: main_cubit.get(context).light
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
              ))
            : productsbuilder(
                context: context,
                model: shop_cubit_home.get(context).home_model_object,
                model_2: shop_cubit_home.get(context).category_model_object!,
              );
      },
      builder: (context, state) {
        var cubit = shop_cubit_home.get(context);
        return Scaffold(
          body: cubit.home_model_object != null
              ? productsbuilder(
                  context: context,
                  model: cubit.home_model_object,
                  model_2: cubit.category_model_object!,
                )
              : Center(child: adaptive(os: getos())),
        );
      },
    );
  }
}
