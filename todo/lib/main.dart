import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shered/BlocObserver.dart';
import 'package:todo/shered/todo_states.dart';
import 'package:todo/shered/toto_cubit.dart';
import 'package:todo/todo.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(main2());
    },
    blocObserver: MyBlocObserver(),
  );
}

class main2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: todo(),
    );
  }
}
