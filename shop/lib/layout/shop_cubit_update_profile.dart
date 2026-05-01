import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/models/profile_model.dart';
import 'package:shop/shered/Network/remote/dio_helper.dart';
import 'package:shop/shered/Network/remote/endpoint.dart';
import 'package:shop/shered/components/constants.dart';

class shop_cubit_update_profile extends Cubit<shop_states> {
  shop_cubit_update_profile() : super(initialstate());

  static shop_cubit_update_profile get(context) => BlocProvider.of(context);

  bool isObscure = true;
  void suffixIconpressed() {
    isObscure = !isObscure;
    emit(isObscure_state());
  }

  bool lang = true;

  String language() {
    emit(language_state());
    return lang ? 'ar' : 'en';
  }

  profile_model? profile_model_object;

  void updateuser({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(update_loading());
    dio_helper
        .putdata(
            token: token,
            url: UPDATE_PROFILE,
            data: {
              'name': name,
              'email': email,
              'phone': phone,
            },
            lang: language())
        ?.then((value) => {
              profile_model_object = profile_model.fromJson(value.data),
              emit(update_success(profile_model_object!)),
            })
        .catchError((error) {
      print(error.toString());
      emit(update_error());
    });
  }
}
