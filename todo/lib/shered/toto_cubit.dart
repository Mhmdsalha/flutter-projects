import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo/modules/archived_tasks_screen.dart';
import 'package:todo/modules/done_tasks_screen.dart';
import 'package:todo/modules/new_tasks_screen.dart';
import 'package:todo/shered/components/components.dart';
import 'package:todo/shered/components/constants.dart';
import 'package:todo/shered/todo_states.dart';

class todo_cubit extends Cubit<todo_states> {
  todo_cubit() : super(initialstate());

  static todo_cubit get(context) => BlocProvider.of(context);
  List<Map> new_tasks = [];
  List<Map> done_tasks = [];
  List<Map> archived_tasks = [];
  late Database database;
  bool isbottomsheetopen = false;
  var scaffold_key = GlobalKey<ScaffoldState>();
  var form_key = GlobalKey<FormState>();
  var titletext = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  int currentindex = 0;
  List<Widget> Screens = [
    new_tasks_screen(),
    done_tasks_screen(),
    archived_tasks_screen(),
  ];

  currentindexx(int index) {
    currentindex = index;
    emit(changBNBstate());
  }

  bottosheetchangestate() {
    isbottomsheetopen ? close_bottomsheet() : open_bottom_sheet();
    emit(BSstate());
  }

  void createdatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) async {
      print('database created');
      await database.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
      print('table created');
    }, onOpen: (database) {
      print('database open');
      getdatafrom_db(database);
    });
    emit(creatDBstate());
  }

  void updatedate({required String status, required int id}) {
    database.rawUpdate(
        'UPDATE tasks SET status=? WHERE id =?', ['$status', id]).then((value) {
      getdatafrom_db(database);
      emit(update_Tasks_state());
    });
  }

  void delete_data({required int id}) {
    database.rawDelete('DELETE FROM tasks WHERE id =?', [id]).then((value) {
      getdatafrom_db(database);
      emit(delete_Tasks_state());
    });
  }

  isrert_to_db(
      {required String title,
      required String time,
      required String date}) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title ,date ,time ,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value Insetrted successfully');
        emit(insertToDBstate());
        getdatafrom_db(database);
      }).catchError((error) {
        print('Error when inserting data ${error.toString()}');
      });
      return null;
    });
  }

  void getdatafrom_db(database) {
    new_tasks = [];
    done_tasks = [];
    archived_tasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          new_tasks.add(element);
        else if (element['status'] == 'Done')
          done_tasks.add(element);
        else
          archived_tasks.add(element);
      });

      emit(getdatafromDBstate());
    });
  }

  void open_bottom_sheet() {
    scaffold_key.currentState!
        .showBottomSheet(
          (context) => Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: form_key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    defultTextfield(
                        validator: (value) {
                          if (value == '') {
                            return 'Enter the title for your task';
                          }
                          return null;
                        },
                        controller: titletext,
                        keyboardType: TextInputType.text,
                        labelText: 'Task Title',
                        prefixIcon: Icons.title),
                    defultTextfield(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the time for your task';
                        }
                        return null;
                      },
                      controller: timeController,
                      keyboardType: TextInputType.datetime,
                      labelText: 'Task Time',
                      prefixIcon: Icons.watch,
                      ontap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          timeController.text = value!.format(context);
                        });
                      },
                    ),
                    defultTextfield(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the date for your task';
                        }
                        return null;
                      },
                      controller: dateController,
                      keyboardType: TextInputType.datetime,
                      labelText: 'Task Date',
                      prefixIcon: Icons.calendar_today,
                      ontap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse("2030-12-01"))
                            .then((value) {
                          dateController.text =
                              DateFormat.yMMMd().format(value!);
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          elevation: 20.0,
        )
        .closed
        .then((value) {
      emit(BSstate());
      isbottomsheetopen = false;
    });
    isbottomsheetopen = true;
  }

  void close_bottomsheet() {
    if (form_key.currentState!.validate()) {
      isrert_to_db(
          title: titletext.text,
          time: timeController.text,
          date: dateController.text);
    }
    ;
    titletext.text = '';
    timeController.text = '';
    dateController.text = '';
  }
}
