import 'package:flutter/material.dart';

BoxDecoration mainScreenDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [
    Colors.lightBlue.shade100,
    Colors.lightBlue.shade200,
    Colors.lightBlue.shade400,
    Colors.lightBlue.shade500
  ], begin: Alignment.topCenter, end: Alignment.bottomRight),
);

const TextStyle textFieldStyle = TextStyle(fontSize: 18);

BoxDecoration listViewContainerBoxDecoration = BoxDecoration(
  color: Colors.white.withOpacity(0.3),
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: Colors.black26,
      spreadRadius: 2,
      blurRadius: 3,
      offset: Offset(5, 5),
    ),
  ],
);
