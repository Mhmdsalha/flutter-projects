import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_states.dart';
import 'package:shop/shered/Network/local/cache_helper.dart';
import 'package:shop/shered/components/constants.dart';

class main_cubit extends Cubit<shop_states> {
  main_cubit() : super(initialstate());

  static main_cubit get(context) => BlocProvider.of(context);

  bool light = true;
  void Islight({bool? form_shered}) {
    if (form_shered != null) {
      light = form_shered;
    } else {
      light = !light;
      cache_helper.savedata(key: 'light', value: light).then((value) {
        emit(theme_state());
      });
    }
  }

  bool isArabic = false;
  void isarabic({
    bool? form_shered2,
  }) {
    if (form_shered2 != null) {
      isArabic = form_shered2;
      lang = isArabic;
      cache_helper.savedata(key: 'isArabic', value: isArabic).then((value) {
        emit(language_state());
      });
    } else {
      isArabic = !isArabic;
      lang = isArabic;

      cache_helper.savedata(key: 'isArabic', value: isArabic).then((value) {
        emit(language_state());
      });
    }
  }
}
