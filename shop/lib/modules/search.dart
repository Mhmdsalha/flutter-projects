import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_home_cubit.dart';
import 'package:shop/layout/shop_search_cubit.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/shered/components/components.dart';
import 'package:shop/layout/main_cubit.dart';
import 'package:shop/shered/components/constants.dart';

class search extends StatelessWidget {
  var searchbox = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => shop_search_cubit(),
        child: BlocConsumer<shop_search_cubit, shop_states>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      child: Column(children: [
                        Form(
                          key: formkey,
                          child: Directionality(
                            textDirection: main_cubit.get(context).isArabic
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: defultTextfield(
                                context: context,
                                textdirection: main_cubit.get(context).isArabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                controller: searchbox,
                                onSubmitted: (String text) {
                                  searchbox.text != ''
                                      ? shop_search_cubit
                                          .get(context)
                                          .search(text)
                                      : null;
                                },
                                keyboardType: TextInputType.text,
                                Color: main_cubit.get(context).light
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).cardColor,
                                labelText: 'Search',
                                prefixIcon: Icons.search),
                          ),
                        ),
                        if (searchbox.text == null) Container(),
                        if (state is search_loading)
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 10),
                            child: LinearProgressIndicator(
                              backgroundColor: main_cubit.get(context).light
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).cardColor,
                            ),
                          ),
                        state is search_success
                            ? Expanded(
                                child: search_screen(
                                  context: context,
                                  model: shop_search_cubit
                                      .get(context)
                                      .search_model_object!,
                                ),
                              )
                            : Container()
                      ]),
                    )));
          },
        ));
  }
}
