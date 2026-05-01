import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/models/Register.dart';
import 'package:shop/shered/Network/remote/dio_helper.dart';
import 'package:shop/shered/Network/remote/endpoint.dart';
import 'package:shop/shered/components/constants.dart';

class shop_cubit_Register extends Cubit<shop_states> {
  shop_cubit_Register() : super(initialstate());

  static shop_cubit_Register get(context) => BlocProvider.of(context);

  bool isObscure = true;
  void suffixIconpressed() {
    isObscure = !isObscure;
    emit(isObscure_state());
  }

  String language() {
    emit(language_state());
    return lang! ? 'ar' : 'en';
  }

  register_model? register_model_object;

  void userRegister(
      {required String email,
      required String name,
      required String phone,
      required String password}) {
    emit(register_loading());
    dio_helper
        .postdata(
            url: REGISTER,
            data: {
              'name': name,
              'email': email,
              'password': password,
              'phone': phone,
            },
            lang: language(),
            token: token)
        ?.then((value) => {
              register_model_object = register_model.fromJson(value.data),
              emit(register_success(register_model_object!))
            })
        .catchError((error) {
      print(error.toString());
      emit(register_error());
    });
  }
}
