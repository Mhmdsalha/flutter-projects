import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/layout/main_cubit.dart';

class adaptive extends StatelessWidget {
  String os;
  adaptive({required this.os});

  @override
  Widget build(BuildContext context) {
    if (this.os == 'android') {
      return CircularProgressIndicator(
        color: main_cubit.get(context).light
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
      );
    } else {
      return CupertinoActivityIndicator(
        color: main_cubit.get(context).light
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
      );
    }
  }
}
