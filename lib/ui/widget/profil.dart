import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/controllers/profil_controller.dart';
import 'package:my_piggy_app/models/profil.dart';
import 'package:my_piggy_app/ui/theme.dart';

import 'add_profil.dart';

class profilHeader extends StatelessWidget {
  final Profil? profilModel;
  profilHeader({super.key, this.profilModel});

  final ProfilController controller = Get.put(ProfilController());

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
        id: 'header/profile',
        builder: (ProfilController controller) {
          final profileData = controller.profilList;
          return Container(
            
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 1.6,
              padding: const EdgeInsets.only(top: 20.0),
              decoration: const BoxDecoration(
                  color: primaryClr,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SizedBox(height: MediaQuery.of(context).size.height/50,),
                  Stack(
                  children: [
                  profileData.isEmpty? const CircleAvatar(
                  radius: 60,
                  backgroundImage:AssetImage('images/profil.jpg'),
                  
                ): CircleAvatar(
                  radius: 60,
                  backgroundImage: profileData.first.foto != null? 
                  MemoryImage(profileData.first.foto!):  Image.asset('images/profil.jpg').image,
                  
                )
                
                      ],
                    ),
                    
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          
                          child: Builder(builder: (context) {
                            final profileData = controller.profilList;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 IconButton(
                                  onPressed: () {
                                    Get.to(() => const editProfil());
                                    },
                                  icon: const Icon(
                                    Icons.edit_square,
                                    color: Colors.white,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(profileData.isEmpty
                                        ? 'Nama Peternak'
                                        : profileData.first.namaPeternak ?? "",style: subtitle,),
                                    Text(profileData.isEmpty
                                        ? 'Nama Peternakan'
                                        : profileData.first.namaPeternakan ?? "",style: subtitle,),
                                  ],
                                ),
                              ],
                            );
                          }
                          ),
                        ),
                       
                      ],
                    ),
                  ]));
        });
  }
}
