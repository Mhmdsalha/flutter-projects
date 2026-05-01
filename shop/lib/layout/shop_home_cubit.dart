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

class shop_cubit_home extends Cubit<shop_states> {
  shop_cubit_home() : super(initialstate());

  static shop_cubit_home get(context) => BlocProvider.of(context);

  List<Widget> Screens = [products(), cateogries(), favorites(), settings()];

  int Currentindex = 0;
  void currentindex(int index) {
    Currentindex = index;
    if (index == 0) {
      favorite_Screen_model_object = null;
      profile_model_object = null;
      cart_Screen_model_object = null;
      gethomedata();
      get_profile_data();
      products();
    } else if (index == 1) {
      cateogries();
      home_model_object = null;
      profile_model_object = null;
      cart_Screen_model_object = null;
      favorite_Screen_model_object = null;
      get_category_data();
    } else if (index == 2) {
      favorites();
      get_favorites_data();
      favorite_Screen_model_object = null;
      profile_model_object = null;
      home_model_object = null;
      cart_Screen_model_object = null;
    } else if (index == 3) {
      settings();
      home_model_object = null;
      cart_Screen_model_object = null;
      get_profile_data();
    }
    emit(BNBstate());
  }

  String language() {
    return lang! ? 'ar' : 'en';
  }

  homemodel? home_model_object;

  Map<int, bool> favorites_list = {};

  void gethomedata() {
    if (home_model_object == null) {
      emit(home_loading());
      dio_helper
          .getdata(url: HOME, token: token, lang: language())
          .then((value) {
        home_model_object = homemodel.fromJson(value.data);
        home_model_object?.data?.productslist?.forEach((element) {
          favorites_list.addAll({element.id: element.infavorites});
          cart_list.addAll({element.id: element.incart});
        });

        print(favorites_list.toString());

        emit(home_success());
      }).catchError((error) async {
        print(error.toString());
        emit(home_error());
      });
    } else {
      emit(home_success());
    }
  }

  categorymodel? category_model_object;

  void get_category_data() {
    dio_helper
        .getdata(url: CATEGORIES, token: token, lang: language())
        .then((value) => {
              category_model_object = categorymodel.fromJson(value.data),
              emit(category_success())
            })
        .catchError((error) async {
      print(error.toString());
      emit(category_error());
    });
  }

  favoritesmodel? favoritesmodel_object;

  void changefavorites(int id) {
    if (favorites_list[id] == true) {
      favorites_list[id] = false;
    } else {
      favorites_list[id] = true;
    }
    emit(change_favorites_success());

    dio_helper
        .postdata(
            url: FAVORITES,
            data: {'product_id': id},
            token: token,
            lang: language())!
        .then((value) {
      favoritesmodel_object = favoritesmodel.fromJson(value.data);
      if (!favoritesmodel_object!.status) {
        if (favorites_list[id] == true) {
          favorites_list[id] = false;
        } else {
          favorites_list[id] = true;
        }
      } else {
        get_favorites_data();
      }
      emit(favorites_success(favoritesmodel_object!));
    }).catchError((error) {
      print(error.toString());
      emit(favorites_error());
    });
  }

  favorite_Screen_model? favorite_Screen_model_object;

  void get_favorites_data() {
    emit(get_favorites_item_success_loading());

    dio_helper
        .getdata(url: FAVORITES, token: token, lang: language())
        .then((value) => {
              favorite_Screen_model_object =
                  favorite_Screen_model.fromJson(value.data),
              emit(get_favorites_item_success())
            })
        .catchError((error) {
      print(error.toString());
      emit(get_favorites_item_error());
    });
  }

  Map<int, bool> cart_list = {};

  cart_model? cart_model_object;

  void add_to_cart(int id) {
    if (cart_list[id] == true) {
      cart_list[id] = false;
    } else {
      cart_list[id] = true;
    }
    emit(change_cart_success());
    dio_helper
        .postdata(
            url: CART,
            data: {'product_id': id},
            token: token,
            lang: language())!
        .then((value) {
      cart_model_object = cart_model.fromJson(value.data);
      if (!cart_model_object!.status) {
        if (cart_list[id] == true) {
          cart_list[id] = false;
        } else {
          cart_list[id] = true;
        }
      } else {
        get_cart_data();
      }
      emit(cart_success(cart_model_object!));
    }).catchError((error) {
      print(error.toString());
      emit(cart_error());
    });
  }

  cart_Screen_model? cart_Screen_model_object;
  void get_cart_data() {
    emit(get_cart_item_success_loading());
    dio_helper
        .getdata(url: CART, token: token, lang: language())
        .then((value) => {
              cart_Screen_model_object = cart_Screen_model.fromJson(value.data),
              emit(get_cart_item_success())
            })
        .catchError((error) {
      print(error.toString());
      emit(get_cart_item_error());
    });
  }

  profile_model? profile_model_object;

  void get_profile_data() {
    if (profile_model_object == null) {
      emit(get_profile_data_success_loading());
      dio_helper
          .getdata(url: PROFILE, token: token, lang: language())
          .then((value) => {
                profile_model_object = profile_model.fromJson(value.data),
                emit(profile_success())
              })
          .catchError((error) {
        print(error.toString());
        emit(profile_error());
      });
    } else {
      emit(get_profile_data_success_loading());
      emit(profile_success());
    }
  }
}
