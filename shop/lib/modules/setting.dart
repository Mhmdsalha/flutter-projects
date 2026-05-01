import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';

import '../styles/Adaptive.dart';

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shop_cubit_home, shop_states>(
      listener: (context, state) {
        state is get_profile_data_success_loading
            ? Center(child: adaptive(os: getos()))
            : profilebuilder(
                context, shop_cubit_home.get(context).profile_model_object!);
      },
      builder: (context, state) {
        var cubit = shop_cubit_home.get(context);
        var cubit2 = main_cubit.get(context);
        return cubit.profile_model_object == null
            ? Center(child: adaptive(os: getos()))
            : profilebuilder(context, cubit.profile_model_object);
      },
    );
  }
}
