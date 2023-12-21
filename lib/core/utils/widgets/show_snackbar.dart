import 'package:flutter/material.dart';

void showSnackBar(context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(showCloseIcon: true, content: Text(message)));
}