import 'package:flutter/material.dart';


// main page background container decoration
BoxDecoration mainScreenDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [
    Colors.lightBlue.shade100,
    Colors.lightBlue.shade200,
    Colors.lightBlue.shade400,
    Colors.lightBlue.shade500
  ], begin: Alignment.topCenter, end: Alignment.bottomRight),
);
// text field (search) text style
const TextStyle textFieldStyle = TextStyle(fontSize: 18);

// horizontal listview container decoration
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

// more info. container text style
TextStyle moreInfoTS= TextStyle(fontSize: 17);

BoxDecoration moreInfoBD=BoxDecoration(
color: Colors.lightBlue.shade100,
borderRadius: BorderRadius.circular(5)
);