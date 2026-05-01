
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archived_tasks_screen.dart';
import 'package:todo/modules/done_tasks_screen.dart';
import 'package:todo/modules/new_tasks_screen.dart';
import 'package:todo/shered/components/components.dart';
import 'package:todo/shered/components/constants.dart';
import 'package:todo/shered/todo_states.dart';
import 'package:todo/shered/toto_cubit.dart';

class todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => todo_cubit()..createdatabase(),
      child: BlocConsumer<todo_cubit, todo_states>(
        listener: (BuildContext context, todo_states state) {
          if (state is insertToDBstate) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, todo_states state) {
          todo_cubit cubit = todo_cubit.get(context);
          return Scaffold(
            key: cubit.scaffold_key,
            appBar: AppBar(
              backgroundColor: Colors.red,
              elevation: 0.0,
              title: Text(
                'TODO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                cubit.bottosheetchangestate();
              },
              child:
                  cubit.isbottomsheetopen ? Icon(Icons.add) : Icon(Icons.edit),
            ),
            bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: false,
                unselectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentindex,
                selectedItemColor: Colors.white,
                backgroundColor: Colors.red,
                onTap: (index) {
                  cubit.currentindexx(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline, color: Colors.white),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined, color: Colors.white),
                    label: 'Archived',
                  ),
                ]),
            body: cubit.Screens[cubit.currentindex],
          );
        },
      ),
    );
  }
}
