import 'package:shop/models/Register.dart';
import 'package:shop/models/cart_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/models/profile_model.dart';

abstract class shop_states {}

class initialstate extends shop_states {}

class login_success extends shop_states {
  final login_model loginsuccess;
  login_success(this.loginsuccess);
}

class update_success extends shop_states {
  final profile_model updatesuccess;
  update_success(this.updatesuccess);
}

class register_success extends shop_states {
  final register_model registersuccess;
  register_success(this.registersuccess);
}

class login_loading extends shop_states {}

class update_loading extends shop_states {}

class search_loading extends shop_states {}

class search_success extends shop_states {}

class search_error extends shop_states {}

class update_error extends shop_states {}

class register_loading extends shop_states {}

class change_login_state extends shop_states {}

class isObscure_state extends shop_states {}

class theme_state extends shop_states {}

class skip_loginscreen_state extends shop_states {}

class skip_onboarding_state extends shop_states {}

class BNBstate extends shop_states {}

class Indicatorstate extends shop_states {}

class home_loading extends shop_states {}

class category_loading extends shop_states {}

class language_state extends shop_states {}

class home_error extends shop_states {}

class login_error extends shop_states {}

class register_error extends shop_states {}

class home_success extends shop_states {}

class change_favorites_success extends shop_states {}

class change_cart_success extends shop_states {}

class favorites_screen_success extends shop_states {}

class favorites_screen_error extends shop_states {}

class favorites_success extends shop_states {
  final favoritesmodel favoritessuccess;
  favorites_success(this.favoritessuccess);
}

class cart_success extends shop_states {
  final cart_model cartsuccess;
  cart_success(this.cartsuccess);
}

class category_success extends shop_states {}

class profile_success extends shop_states {}

class category_error extends shop_states {}

class profile_error extends shop_states {}

class favorites_error extends shop_states {}

class cart_error extends shop_states {}

class get_favorites_item_success extends shop_states {}

class get_cart_item_success extends shop_states {}

class get_favorites_item_success_loading extends shop_states {}

class get_cart_item_success_loading extends shop_states {}

class get_favorites_item_error extends shop_states {}

class get_cart_item_error extends shop_states {}

class get_profile_data_success_loading extends shop_states {}

class change_profile_image_state extends shop_states {}
