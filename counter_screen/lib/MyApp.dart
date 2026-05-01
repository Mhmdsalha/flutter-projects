import 'package:counter_screen/cubit/countercubit.dart';
import 'package:counter_screen/cubit/counterstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => countercubit(),
      child: BlocConsumer<countercubit, counterstates>(
        listener: (context, state) {
          if (state is minus_state) print('minus state');
          if (state is plus_state) print('plus state');
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        countercubit.get(context).minus();
                      },
                      child: Text(
                        'Miuns',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  Text(
                    '${countercubit.get(context).x}',
                    style: TextStyle(fontSize: 60),
                  ),
                  TextButton(
                      onPressed: () {
                        countercubit.get(context).plus();
                      },
                      child: Text(
                        'Plus',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
