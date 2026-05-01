import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/models/cart_Screen_model.dart';
import 'package:shop/models/cart_model.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/favorite_Screen_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/profile_model.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/cateogries.dart';
import 'package:shop/modules/favorites.dart';
import 'package:shop/modules/products.dart';
import 'package:shop/modules/setting.dart';
import 'package:shop/shered/Network/remote/endpoint.dart';
import 'package:shop/shered/Network/remote/dio_helper.dart';
import 'package:shop/shered/components/constants.dart';

class shop_search_cubit extends Cubit<shop_states> {
  shop_search_cubit() : super(initialstate());

  static shop_search_cubit get(context) => BlocProvider.of(context);

  String language() {
    return lang! ? 'ar' : 'en';
  }

  search_model? search_model_object;

  void search(String? Searchtext) {
    emit(search_loading());
    dio_helper
        .postdata(
            url: SEARCH,
            data: {'text': Searchtext},
            lang: language(),
            token: token)
        ?.then((value) => {
              search_model_object = search_model.fromJson(value.data),
              print(search_model_object!.data.data),
              emit(search_success())
            })
        .catchError((error) {
      print(error.toString());
      emit(search_error());
    });
  }
}
