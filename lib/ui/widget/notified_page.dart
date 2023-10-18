import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/ui/theme.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;

  const NotifiedPage({Key?key, required this.label}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryClr,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode?Colors.white:Colors.white,
        ),
        title: Text(
          label.toString().split("|")[0],
          style: const TextStyle(
          color: Colors.black
        ),),
      ),
      body: Center(
        child: Container(
          height: 600,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primaryClr
            
          ),
          child: 
            Center(
              child: Text(label.toString().split("|")[0], style: TextStyle(
              color: Get.isDarkMode?Colors.black:Colors.white,
              fontSize: 30
               )
              ),
            ),
        ),
      ),
    );
  }
}