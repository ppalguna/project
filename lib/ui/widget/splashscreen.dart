import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';

import 'package:my_piggy_app/ui/home_page.dart';
import 'package:my_piggy_app/ui/theme.dart';

import '../../controllers/task_controller.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>{
  final _taskController =Get.put(TaskController());
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 4),(){
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    });
      _taskController.getTask();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: primaryClr,
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
            
              padding: const EdgeInsets.all(1),
              child: Image.asset(
                'images/logosp.png',
                height: MediaQuery.of(context).size.height/2.5,
              ),
              
            ),
            
            // const CircularProgressIndicator.adaptive(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            // )
          ],
        ),
      ),
    );
    
  }
}