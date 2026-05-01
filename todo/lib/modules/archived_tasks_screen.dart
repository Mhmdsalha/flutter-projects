import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shered/components/components.dart';
import 'package:todo/shered/todo_states.dart';
import 'package:todo/shered/toto_cubit.dart';

class archived_tasks_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<todo_cubit, todo_states>(
        listener: (BuildContext context, todo_states state) {},
        builder: (BuildContext context, todo_states state) {
          var tasks = todo_cubit.get(context).archived_tasks;
          return tasks.isEmpty
              ? Center(
                  child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.black38,
                        size: 150,
                      ),
                      Text(
                        'Now Tasks yet , add some tasks',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )
                    ],
                  ),
                ))
              : buildtask(list: tasks);
        });
  }
}
