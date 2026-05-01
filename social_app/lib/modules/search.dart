import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shop/layout/social_app_states.dart';
import 'package:shop/layout/social_cubit_home.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/styles/Adaptive.dart';
import 'package:shop/styles/textstyle.dart';

import '../shered/components/constants.dart';

class search_screen extends StatelessWidget {
  var searchtext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<social_cubit_home, social_app_states>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: textstyle(
                context: context,
                arabicText: 'البحث',
                englishText: 'Search',
                fontsize: 25,
                TextAlign: TextAlign.start,
                color: Colors.deepOrange),
          ),
          body: Column(children: [
            defultTextfield(
              controller: searchtext,
              keyboardType: TextInputType.text,
              prefixIcon: IconlyBroken.search,
              onchange: (value) {
                social_cubit_home.get(context).searchusers(value);
              },
              onSubmitted: (value) {
                social_cubit_home.get(context).searchusers(searchtext.text);
              },
              context: context,
              EdgeInsetsGeometry: EdgeInsetsDirectional.all(10),
              width: MediaQuery.of(context).size.width,
            ),
            state is getAlluser_loading
                ? Center(child: adaptive(os: getos()))
                : Expanded(child: searchusersBuilderScreen(context))
          ]),
        );
      },
    );
  }
}
