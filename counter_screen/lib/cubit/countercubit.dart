import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:counter_screen/cubit/counterstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class countercubit extends Cubit<counterstates> {
  countercubit() : super(initialstates());

  static countercubit get(context) => BlocProvider.of(context);

  var x = 0;

  minus() {
    x--;
    emit(minus_state());
  }

  plus() {
    x++;
    emit(plus_state());
  }
}
