import 'package:flutter/material.dart';

class myMultitab extends StatefulWidget {
  const myMultitab({super.key});

  @override
  State<myMultitab> createState() => _myMultitabState();
}

class _myMultitabState extends State<myMultitab> {
 

  int current = 0;
    double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 0;
      case 1:
        return MediaQuery.of(context).size.width/2;
     
      default:
        return 0;
    }
  }
   double changeContainerWidth() {
    switch (current) {
      case 0:
        return MediaQuery.of(context).size.width/2;
      case 1:
        return MediaQuery.of(context).size.width/2;
     
      default:
        return 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}