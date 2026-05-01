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
        color: Theme.of(context).primaryColor,
      );
    } else {
      return CupertinoActivityIndicator(
        color: Theme.of(context).primaryColor,
      );
    }
  }
}
