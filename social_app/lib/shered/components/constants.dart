import 'package:flutter/material.dart';
import 'dart:io';

String? Uid;
String? Token;
const String fcmServerKey = String.fromEnvironment('FCM_SERVER_KEY');
Widget? startscreen;
bool? lang;
bool? skipwelcomeScreen;
String? name;

String getos() {
  return Platform.operatingSystem;
}
