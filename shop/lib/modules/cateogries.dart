import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/shered/components/components.dart';

class cateogries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shop_cubit_home, shop_states>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = shop_cubit_home.get(context);
        return categorybuilder_screen(
          context: context,
          model: cubit.category_model_object!,
        );
      },
    );
  }
}
