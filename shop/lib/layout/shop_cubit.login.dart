import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/shered/Network/remote/dio_helper.dart';
import 'package:shop/shered/Network/remote/endpoint.dart';
import 'package:shop/shered/components/constants.dart';

class shop_cubit_login extends Cubit<shop_states> {
  shop_cubit_login() : super(initialstate());

  static shop_cubit_login get(context) => BlocProvider.of(context);

  bool isObscure = true;
  void suffixIconpressed() {
    isObscure = !isObscure;
    emit(isObscure_state());
  }

  login_model? login_model_object;
  bool lang = true;

  String language() {
    emit(language_state());
    return lang ? 'ar' : 'en';
  }

  void userlogin({required String email, required String password}) {
    emit(login_loading());
    dio_helper
        .postdata(
            url: LOGIN,
            data: {
              'email': email,
              'password': password,
            },
            lang: language(),
            token: token)
        ?.then((value) => {
              login_model_object = login_model.fromJson(value.data),
              emit(login_success(login_model_object!))
            })
        .catchError((error) {
      print(error.toString());
      emit(login_error());
    });
  }
}
