import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final child;
  const Event({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10), )
      ),
      child: child,
    );
  }
}