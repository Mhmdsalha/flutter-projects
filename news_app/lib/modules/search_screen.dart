import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_cubit.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/shered/components/components.dart';
import 'package:news_app/shered/components/constants.dart';
import 'package:news_app/styles/Adaptive.dart';

class search_screen extends StatelessWidget {
  var search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<news_cubit, news_states>(
        listener: (context, state) {},
        builder: (context, state) {
          var search = news_cubit.get(context).search;
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(),
                body: Container(
                  width: double.infinity,
                  child: Column(children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: defultTextfield(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'search must not be empty';
                          }
                          return null;
                        },
                        controller: search_controller,
                        keyboardType: TextInputType.text,
                        Color: Theme.of(context).primaryColor,
                        labelText: 'Search',
                        prefixIcon: Icons.search,
                        onchange: (value) {
                          news_cubit.get(context).getsearch(value);
                        },
                      ),
                    ),
                    Expanded(
                        child: search_controller.text.isEmpty
                            ? Center(
                                child: Text(
                                  'Start typing to search for articles',
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : state is error_data_state
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Text(
                                        state.error,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : search.length == 0
                                    ? Center(child: adaptive(os: getos()))
                                    : newslistbuilder(list: search))
                  ]),
                ),
              ));
        });
  }
}
