import 'dart:ffi';

import 'package:flutter/material.dart';

Widget defultTextfield(
        {required final FormFieldValidator<String>? validator,
        required TextEditingController controller,
        required TextInputType keyboardType,
        required String labelText,
        required IconData prefixIcon,
        IconData? suffixIcon,
        void Function()? suffixIconpressed,
        bool isPassword = false}) =>
    Container(
      margin: const EdgeInsetsDirectional.only(
        top: 20,
      ),
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        controller: controller,
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





Widget defultbutton({
  double width = double.infinity,
  Color color = Colors.blue,
  required void Function() function,
  required String buttontext,
}) =>
    Container(
      width: width,
      margin: const EdgeInsetsDirectional.only(top: 30),
      color: color,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          buttontext.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
