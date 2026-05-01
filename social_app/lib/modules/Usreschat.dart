import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/Adaptive.dart';

class Usreschat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<social_cubit_home, social_app_states>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: social_cubit_home.get(context).alluserlist.isEmpty
              ? Center(child: adaptive(os: getos()))
              : chatuserBuilderScreen(context),
        );
      },
    );
  }
}
