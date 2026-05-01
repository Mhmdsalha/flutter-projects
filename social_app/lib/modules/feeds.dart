import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/shered/components/constants.dart';
import 'package:shop/styles/Adaptive.dart';
import 'package:shop/styles/textstyle.dart';

class feeds_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<social_cubit_home, social_app_states>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = social_cubit_home.get(context).usermodel_object;
          return Scaffold(
              body: social_cubit_home.get(context).usermodel_object == null
                  ? Center(child: adaptive(os: getos()))
                  : RefreshIndicator(
                      color: Colors.deepOrange,
                      child: postBuilderScreen(
                        context,
                      ),
                      onRefresh: () async {
                        social_cubit_home.get(context).getPosts();
                        return Future<void>.delayed(const Duration(seconds: 3));
                      }));
        });
  }
}
