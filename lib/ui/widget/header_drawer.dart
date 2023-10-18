import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/controllers/profil_controller.dart';

import '../theme.dart';
import 'add_profil.dart';

class sideProfil extends StatelessWidget {
  const sideProfil({super.key});

  @override
  Widget build(BuildContext context){
    final profilController = Get.put(ProfilController());

@override
void initState(){
  profilController.getProfil();
}
    return Container(
      width:  double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      decoration: const BoxDecoration(
        color: primaryClr,
         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            height: 90.0,
            decoration:  const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
              image: AssetImage('images/profil.jpg')
            ),   
            ), 
          ),
         Row(
           children: [
            Padding(
                padding: const EdgeInsets.only(left: 80),
             child:  Text(profilController.profilList[1].namaPeternak ??''),
               
             
           ),
            IconButton(
                 onPressed: (){
                  Get.to(() => const editProfil());          
                  },
                 icon: const Icon(
                 Icons.edit_square,
                 color: Colors.white,
                 
                ),
              ), 
           ],
         ),  
        ], 
      ),
    );
  }
}