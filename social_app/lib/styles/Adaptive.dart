import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class adaptive extends StatelessWidget {
  String os;
  adaptive({required this.os});

  @override
  Widget build(BuildContext context) {
    if (this.os == 'android') {
      return CircularProgressIndicator(
        color: Colors.deepOrange,
      );
    } else {
      return CupertinoActivityIndicator(
        color: Colors.deepOrange,
      );
    }
  }
}
