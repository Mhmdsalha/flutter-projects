import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/main_cubit.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/modules/business.dart';
import 'package:news_app/modules/science.dart';
import 'package:news_app/modules/sports.dart';
import 'package:news_app/shered/Network/remote/dio_helper.dart';
import 'package:news_app/shered/components/constants.dart';

class news_cubit extends Cubit<news_states> {
  news_cubit() : super(initialstate());

  static news_cubit get(context) => BlocProvider.of(context);

  List<Widget> Screens = [
    business_screen(),
    sports_screen(),
    science_screen(),
  ];

  int Currentindex = 0;
  void currentindex(int index) {
    Currentindex = index;
    if (index == 1) {
      getsports();
    } else if (index == 2) {
      getscience();
    }
    emit(BNBstate());
  }

  bool lang = isArabic;

  bool _ensureApiKey() {
    if (newsApiKey.isEmpty) {
      emit(error_data_state(missingNewsApiKeyMessage));
      return false;
    }
    return true;
  }

  Map<String, dynamic> _queryWithApiKey(Map<String, dynamic> query) {
    return {
      ...query,
      'apiKey': newsApiKey,
    };
  }

  String language() {
    emit(language_state());
    return lang ? 'ar' : 'en';
  }

  List<dynamic> Business = [];
  void getBusiness() {
    if (!_ensureApiKey()) {
      return;
    }

    if (Business.length == 0) {
      emit(business_loading_state());
      dio_helper
          .getdata(
              url: 'v2/top-headlines',
              query: _queryWithApiKey({
                'language': language(),
                'category': 'Business',
              }))
          .then((value) {
        Business = value.data['articles'];
        print(Business[0]['title']);
        emit(get_business_data_state());
      }).catchError((error) {
        emit(error_data_state(error.toString()));
        print(error.toString());
      });
    } else {
      emit(get_business_data_state());
    }
  }

  List<dynamic> sports = [];
  void getsports() {
    if (!_ensureApiKey()) {
      return;
    }

    emit(sports_loading_state());

    if (sports.length == 0) {
      dio_helper
          .getdata(
              url: 'v2/top-headlines',
              query: _queryWithApiKey({
                'language': language(),
                'category': 'sport',
              }))
          .then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(get_sports_data_state());
      }).catchError((error) {
        emit(error_data_state(error.toString()));
        print(error.toString());
      });
    } else {
      emit(get_sports_data_state());
    }
  }

  List<dynamic> search = [];
  void getsearch(String value) {
    search = [];

    if (value.isEmpty) {
      emit(get_search_data_state());
      return;
    }

    if (!_ensureApiKey()) {
      return;
    }

    emit(search_loading_state());
    dio_helper
        .getdata(
            url: 'v2/everything',
            query: _queryWithApiKey({
              'language': language(),
              'q': '$value',
            }))
        .then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(get_search_data_state());
    }).catchError((error) {
      emit(error_data_state(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> science = [];
  void getscience() {
    if (!_ensureApiKey()) {
      return;
    }

    if (science.length == 0) {
      emit(science_loading_state());
      dio_helper
          .getdata(
              url: 'v2/top-headlines',
              query: _queryWithApiKey({
                'language': language(),
                'category': 'science',
              }))
          .then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(get_science_data_state());
      }).catchError((error) {
        emit(error_data_state(error.toString()));
        print(error.toString());
      });
    } else {
      emit(get_science_data_state());
    }
  }
}
