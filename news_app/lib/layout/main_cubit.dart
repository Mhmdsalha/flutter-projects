import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_states.dart';
import 'package:news_app/shered/Network/local/cache_helper.dart';

class main_cubit extends Cubit<news_states> {
  main_cubit() : super(initialstate());

  static main_cubit get(context) => BlocProvider.of(context);



  bool light = true;
  bool isArabic = true;

  void Islight({bool? form_shered}) {
    if (form_shered != null) {
      light = form_shered;
    } else {
      light = !light;
      cache_helper.putdate(key: 'light', value: light).then((value) {
        emit(theme_state());
      });
    }
  }
  void isarabic({bool? form_shered2}) {
    if (form_shered2 != null) {
      isArabic = form_shered2;
    } else {
      isArabic = !isArabic;
      cache_helper.putdate(key: 'isArabic', value: isArabic).then((value) {
        emit(language_state());
      });
    }
  }

}
