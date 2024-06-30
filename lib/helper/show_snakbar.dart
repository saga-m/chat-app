import 'package:chat1/main.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context , String massage) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(massage),
  ),);
}