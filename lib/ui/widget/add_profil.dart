import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_piggy_app/db/db_helper.dart';
import 'package:my_piggy_app/models/profil.dart';
import 'package:my_piggy_app/ui/widget/input_field.dart';
import 'package:my_piggy_app/ui/widget/utils.dart';

import '../../controllers/profil_controller.dart';
import '../theme.dart';
import 'button.dart';


class editProfil extends StatefulWidget {
  const editProfil({super.key});

  @override
  State<editProfil> createState() => _editProfilState();
}

class _editProfilState extends State<editProfil> {
  Uint8List? _image;
  Image profilImage =Image.asset('images/profil.jpg');
  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery,50);

    setState(() {
       _image = img;
     
    });
   
  }
  final ProfilController _profilController = Get.put(ProfilController());
   late double _progress;
  Timer? _timer;
  DBHelper mydb = DBHelper();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        
        title: 
        Text(
          'Edit Profil',
          style: subStyle.copyWith(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: context.theme.dialogBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode?Colors.white:Colors.black,
          
        ),
    
      ),
      body: Container(
         color: context.theme.dialogBackgroundColor,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
             Stack(
              children: [
                _profilController.foto != null
                  ? CircleAvatar(
                    radius: 64,
                    backgroundImage:_image == null
                       ? MemoryImage( _profilController.foto!)
                       : MemoryImage(_image!),
                  )
                  :  CircleAvatar(
                  radius: 64,
                  backgroundImage: _image != null
                  ? MemoryImage(_image!)
                  : Image.asset('images/profil.jpg').image,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: 
                    IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo, 
                      shadows: <Shadow> [Shadow(
                        color: Colors.white, blurRadius: 5.0
                      )
                    ]
                  ),
                  
                ),
                )
              ],
             ),
             Padding(
               padding: const EdgeInsets.all(30),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyInputField(
                    title: "Nama Peternak",
                    hint: "Masukan nama anda",
                    controller: _profilController.namaPeternakController,
                  ),
                  MyInputField(
                    title: "Nama Peternakan",
                    hint: "Masukan nama peternakan ",
                    controller: _profilController.namaPeternakanController,
                  ),
                   SizedBox(
                       width: MediaQuery.of(context).size.width/0.2,
                       height: MediaQuery.of(context).size.height/6.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            
                            MyBotton(label: "Simpan ", onTap: () {
                              _addProfilToDb();
                               _progress = 0;
                                _timer?.cancel();
                                _timer = Timer.periodic(const Duration(milliseconds: 25), (Timer timer) {
                                  EasyLoading.instance
                                    ..displayDuration = const Duration(milliseconds: 1000)
                                    ..loadingStyle =
                                        EasyLoadingStyle.custom //This was missing in earlier code
                                    ..backgroundColor = primaryClr
                                    ..progressColor = Colors.white
                                    ..indicatorColor = Colors.white
                                    ..progressColor = Colors.white
                                    ..maskColor = Colors.white
                                    ..textColor = Colors.white
                                    ..dismissOnTap = true;
                                  EasyLoading.showProgress(_progress,
                                      status: '${(_progress * 100).toStringAsFixed(0)}%');
                                  _progress += 0.03;

                                  if (_progress >= 1) {
                                    _timer?.cancel();
                                    EasyLoading.dismiss();
                                    Get.snackbar(
                                      "Sukses",
                                      "Input Profil Berhasil",
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.white,
                                      boxShadows: [
                                        const BoxShadow(
                                          color: primaryClr,
                                          spreadRadius: 0,
                                          blurRadius: 1.5,
                                          offset: Offset(0, 0),
                                        )
                                      ],
                                      icon: const Icon(
                                        Icons.beenhere_outlined,
                                        color: primaryClr,
                                      ),
                                      colorText: primaryClr,
                                    );
                                  }
                                }); 
                               
                            }) 
                           
                          ],
                        ),
                        
                      )
                  
                ],
                           ),
             )
            ],
            
          ),
          
        ),
        
        
      
      
    );
    
  }
  _addProfilToDb() async {
 int value = await _profilController.addProfil(
  profil : Profil(
    id: 1,
        namaPeternak: _profilController.namaPeternakController.text,
        namaPeternakan: _profilController.namaPeternakanController.text,
        foto:_profilController.foto=_image,
    ),
  );

  
  
  print("my id profil is"" $value");
  _profilController.update(['header/profile']);
  _profilController.getProfil();
  
}
 
}