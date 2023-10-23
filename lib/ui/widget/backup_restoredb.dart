import 'dart:async';
import 'dart:io';

//import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/controllers/note_controller.dart';
import 'package:my_piggy_app/controllers/pakan_controller.dart';
import 'package:my_piggy_app/controllers/profil_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restart_app/restart_app.dart';

//import 'package:my_piggy_app/db/db_helper.dart';
import '../../controllers/pig_controller.dart';
import '../../controllers/task_controller.dart';
import '../theme.dart';


class backupRestoreData extends StatefulWidget {
  const backupRestoreData({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<backupRestoreData> createState() => _backupRestoreDataState();
}

class _backupRestoreDataState extends State<backupRestoreData> {
  final PigController _pigController = Get.put(PigController());
  final PakanController _pakanController = Get.put(PakanController());
  final NoteController _noteController = Get.put(NoteController());
  final ProfilController _profilController = Get.put(ProfilController());
  final _taskController =Get.put(TaskController());
  late double _progress;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
     EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        
        title: 
        Text('Backup dan Restore', style: subStyle.copyWith( color: Get.isDarkMode?Colors.white:Colors.black,),),
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: context.theme.dialogBackgroundColor,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode?Colors.white:Colors.black,
          
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color:context.theme.dialogBackgroundColor,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/2.8,
                width: MediaQuery.of(context).size.width/1,
                decoration: const BoxDecoration(
                  color:primaryClr,
                  borderRadius: BorderRadius.all(Radius.circular(20),
                  )
                  
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, ),
                  child: Column(
                    children: [
                      Image.asset('images/backup.png',height: MediaQuery.of(context).size.height/8,),
                      SizedBox(height: MediaQuery.of(context).size.height/40),
                      Text("Amankan data anda", style: subtitle.copyWith(color: Colors.white),),
                      SizedBox(height: MediaQuery.of(context).size.height/80),
                      Text("Data hasil backup anda akan tersimpan pada:\n"
                      "File/Android/(databasestasks.db)", style: subtitle.copyWith(color: Colors.white,fontSize: 12, ),textAlign: TextAlign.center,),
                      SizedBox(height: MediaQuery.of(context).size.height/50),
                      ElevatedButton(
                        onPressed: () async {
                          if(_noteController.noteList.isEmpty&&_pakanController.pakanList.isEmpty&&_pigController.pigList.isEmpty&&_taskController.taskList.isEmpty&&_profilController.profilList.isEmpty){
                           await _backupEmpty();
                          }else{
                           await backuDb();
                             _progress = 0;
                        _timer?.cancel();
                        _timer = Timer.periodic(const Duration(milliseconds: 50),
                            (Timer timer) {
                          EasyLoading.instance
                          ..displayDuration =const Duration(milliseconds: 2000)
                          ..loadingStyle =EasyLoadingStyle.custom //This was missing in earlier code
                          ..backgroundColor = primaryClr
                          ..progressColor = Colors.white
                          ..indicatorColor = Colors.white
                          ..progressColor = Colors.white
                          ..maskColor = Colors.white
                          ..textColor= Colors.white
                          ..dismissOnTap = true;
                          EasyLoading.showProgress(_progress,
                          
                            status: '${(_progress * 100).toStringAsFixed(0)}%');
                          _progress += 0.03;
                          if (_progress >= 1) {
                            _timer?.cancel();
                            _sukssesBackup();
                            EasyLoading.dismiss();
                            
                          }
                        });
                           
                          }
                           
                          },
                          child: const Text('Backup'),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox( height: MediaQuery.of(context).size.height/50,),
              Container(
                height: MediaQuery.of(context).size.height/2.8,
                width: MediaQuery.of(context).size.width/1,
                decoration: const BoxDecoration(
                  color:primaryClr,
                  borderRadius: BorderRadius.all(Radius.circular(20),
                  )
                  
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, ),
                  child: Column(
                    children: [
                      Image.asset('images/restore.png',height: MediaQuery.of(context).size.height/8,),
                      SizedBox(height: MediaQuery.of(context).size.height/40),
                      Text("Pulihkan data anda", style: subtitle.copyWith(color: Colors.white),),
                      SizedBox(height: MediaQuery.of(context).size.height/80),
                      Text("Jika file anda adalah file baru, silahkan\n"
                      "masukan file db anda pada penyimpanan anda:\n"
                      "File/Android/(databasestasks.db)", style: subtitle.copyWith(color: Colors.white,fontSize: 12, ),textAlign: TextAlign.center,),
                      SizedBox(height: MediaQuery.of(context).size.height/50),
                      ElevatedButton(
                        onPressed: ()  async{
                          restoreDB();
                        _progress = 0;
                        _timer?.cancel();
                        _timer = Timer.periodic(const Duration(milliseconds: 50),
                            (Timer timer) {
                          EasyLoading.instance
                          ..displayDuration =const Duration(milliseconds: 2000)
                          ..loadingStyle =EasyLoadingStyle.custom //This was missing in earlier code
                          ..backgroundColor = primaryClr
                          ..progressColor = Colors.white
                          ..indicatorColor = Colors.white
                          ..progressColor = Colors.white
                          ..maskColor = Colors.white
                          ..textColor= Colors.white
                          ..dismissOnTap = true;
                          EasyLoading.showProgress(_progress,
                          
                              status: '${(_progress * 100).toStringAsFixed(0)}%');
                          _progress += 0.03;
                          
                          if (_progress >= 1) {
                            _timer?.cancel();
                            EasyLoading.dismiss();
                            _sukssesRestore();
                            _showdialog();
                          }
                        });
                       // _showdialog();
                          },
                          child: const Text('Restore'),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showdialog(){
    return  showDialog(
    context: context,
     builder: (_) => AlertDialog(
      
        title: const Text("Data berhasil dipulihkan, silahkan restart aplikasi anda"),
        actions: [
        Column(
          children: [
             TextButton(
                  child: const Text('Nanti saja'),
            onPressed: () => Get.back()
           ),
           ],
           ),
          Column(
             children: [
               TextButton(
                  child: const Text('Restart'),
                       onPressed: (){
                       Restart.restartApp();
                                      
                       } 
                    ),
                  ],
               )                         
             ],  
                                            
            ),
        );
  }
  _sukssesBackup(){
    Get.snackbar("Sukses", "Data Berhasil Dicadangkan",
      snackPosition:  SnackPosition.TOP,
    backgroundColor: Colors.white,
      boxShadows: [
                  const BoxShadow(
                    color: primaryClr,
                    spreadRadius: 0,
                    blurRadius: 1.5,
                    offset: Offset(0, 0),
                  )
                ],
    icon: const Icon(Icons.beenhere_outlined,color: primaryClr,) ,
    colorText: primaryClr,
    );   

  }
  _sukssesRestore(){
    Get.snackbar("Sukses", "Data Berhasil Dipulihkan",
      snackPosition:  SnackPosition.TOP,
    backgroundColor: Colors.white,
      boxShadows: [
                  const BoxShadow(
                    color: primaryClr,
                    spreadRadius: 0,
                    blurRadius: 1.5,
                    offset: Offset(0, 0),
                  )
                ],
    icon: const Icon(Icons.beenhere_outlined,color: primaryClr,) ,
    colorText: primaryClr,
    );   
  
  }
  _backupEmpty(){
    Get.snackbar("Maaf", "Data Anda Masih Kosong",
    snackPosition:  SnackPosition.TOP,
    backgroundColor: Colors.red,
      boxShadows: [
                  const BoxShadow(
                    color: Colors.red,
                    spreadRadius: 0,
                    blurRadius: 1.5,
                    offset: Offset(0, 0),
                  )
                ],
      icon: const Icon(
        Icons.warning_amber_outlined,
        color: Colors.white,
      ),
    colorText: Colors.white,
    );  
  
  }
restoreDB() async{
  var status  = await Permission.manageExternalStorage.status;
  if(!status.isGranted){
    await Permission.manageExternalStorage.request();
  }
  var status1 = await Permission.manageExternalStorage.status;
  if(!status1.isGranted){
    await Permission.storage.request();
  }
  try{
    File savedDBFile=File(
      '/storage/emulated/0/Android/databasestasks.db');
    await savedDBFile.copy(
      '/data/user/0/com.example.my_piggy_app/databasestasks.db');

      setState(() {
        _pigController.getPig();
        _taskController.getTask();
      });
     
     // _showdialog();
  }
  
  catch(e){
    print("eror ${e.toString()}");
  }
}

backuDb()async{
  var status = await Permission.manageExternalStorage.status;
  if (!status.isGranted){
    await Permission.manageExternalStorage.request();
  }
  var status1 = await Permission.storage.status;
  if(!status1.isGranted){
    await Permission.storage.request();
  }
  try{
    File ourDBFile =File(
      '/data/user/0/com.example.my_piggy_app/databasestasks.db'
    );
    Directory? folderPathforDBFile =Directory('/storage/emulated/0/Android/');
    await folderPathforDBFile.create();
    await ourDBFile.copy('/storage/emulated/0/Android/databasestasks.db');
    
    

  }catch(e){
    print("eror ${e.toString()}");
  }
} 



}