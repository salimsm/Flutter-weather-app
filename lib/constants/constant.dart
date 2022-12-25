import 'package:flutter/material.dart';


// main page background container decoration
//BoxDecoration mainScreenDecoration =
// text field (search) text style
const TextStyle textFieldStyle = TextStyle(fontSize: 18);

// horizontal listview container decoration
BoxDecoration listViewContainerBoxDecoration = BoxDecoration(
  color: Colors.white.withOpacity(0.3),
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: Color(0xffeef1f5),
      spreadRadius: 10,
      // blurRadius: 3,
      offset: Offset(5, 5),
    ),
  ],
);

// more info. container text style
TextStyle moreInfoTS= TextStyle(fontSize: 17,fontFamily: 'Laila',);

BoxDecoration moreInfoBD=BoxDecoration(
borderRadius: BorderRadius.circular(5)
);