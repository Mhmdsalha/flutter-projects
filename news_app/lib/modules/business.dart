import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_cubit.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/shered/components/components.dart';
import 'package:news_app/shered/components/constants.dart';
import 'package:news_app/styles/Adaptive.dart';

class business_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<news_cubit, news_states>(
        listener: (BuildContext context, news_states state) {},
        builder: (BuildContext context, news_states state) {
          var Businesslist = news_cubit.get(context).Business;
          if (state is error_data_state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            );
          }

          return Businesslist.length == 0
              ? Center(child: adaptive(os: getos()))
              : newslistbuilder(list: Businesslist);
        });
  }
}
