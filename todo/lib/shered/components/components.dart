import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:todo/shered/toto_cubit.dart';

Widget defultTextfield(
        {required final FormFieldValidator<String>? validator,
        required TextEditingController controller,
        required TextInputType keyboardType,
        required String labelText,
        required IconData prefixIcon,
        IconData? suffixIcon,
        bool? enabled = true,
        void Function()? suffixIconpressed,
        void Function()? ontap,
        bool isPassword = false}) =>
    Container(
      margin: const EdgeInsetsDirectional.only(
        top: 20,
      ),
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        controller: controller,
        enabled: enabled,
        onTap: ontap,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: suffixIconpressed, icon: Icon(suffixIcon))
                : null),
      ),
    );

Widget newtasks(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        todo_cubit.get(context).delete_data(id: model['id']);
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(
            top: 10, start: 10, end: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsetsDirectional.only(start: 15, top: 5, bottom: 5),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40,
              child: Text(
                '${model['time']}',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(bottom: 3),
                      child: Text(
                        '${model['title']}',
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '${model['date']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  todo_cubit
                      .get(context)
                      .updatedate(status: 'Done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.white,
                )),
            Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: IconButton(
                  onPressed: () {
                    todo_cubit
                        .get(context)
                        .updatedate(status: 'Archived', id: model['id']);
                  },
                  icon: Icon(
                    Icons.archive,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );

Widget buildtask({required List list}) => ListView.separated(
    itemBuilder: (context, index) => newtasks(list[index], context),
    separatorBuilder: (context, index) => SizedBox(),
    itemCount: list.length);
