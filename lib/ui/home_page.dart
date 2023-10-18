
import 'dart:core';
import 'dart:io';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_piggy_app/controllers/note_controller.dart';
import 'package:my_piggy_app/controllers/pakan_controller.dart';
import 'package:my_piggy_app/controllers/pig_controller.dart';
import 'package:my_piggy_app/controllers/task_controller.dart';
import 'package:my_piggy_app/models/profil.dart';
import 'package:my_piggy_app/models/task.dart';
import 'package:my_piggy_app/services/Notification_services.dart';
import 'package:my_piggy_app/services/theme_services.dart';
import 'package:my_piggy_app/ui/add_task_bar.dart';
import 'package:my_piggy_app/ui/theme.dart';
import 'package:my_piggy_app/ui/widget/about.dart';
import 'package:my_piggy_app/ui/widget/add_note.dart';
import 'package:my_piggy_app/ui/widget/backup_restoredb.dart';
import 'package:my_piggy_app/ui/widget/note_Tile.dart';
import 'package:my_piggy_app/ui/widget/pigHealth.dart';
import 'package:my_piggy_app/ui/widget/profil.dart';
import 'package:my_piggy_app/ui/widget/task_tile.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../db/db_helper.dart';
import '../models/note.dart';
import '../services/permissionNotif.dart';
import 'widget/dataDiagram.dart';
import 'widget/data_pakan_ternak.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  Profil?profil;
  DateTime _selectedDate = DateTime.now();
  NotifyHelper notifH = NotifyHelper();
  final _taskController =Get.put(TaskController());
  final _noteController =Get.put(NoteController());
  final _pakanController =Get.put(PakanController());
  // final _pigController = Get.put(PigController());
  var count = 0.obs;
  // ignore: prefer_typing_uninitialized_variables
  var notifyHelper;
  String? _packageInfoText;
  List<String> tabs = [
    "Penjadwalan",
    "Catatan",
    
  ];

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
  void initState() {
  
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    _getInfoPressed();
    const notif();
    
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      backgroundColor: context.theme.dialogBackgroundColor,
      appBar: _appBar(),
      body: Column(
        children:  [
        _addTaskBar(),
        _addDateBar(),
          //TODO tab bar menu
         Container(
              margin: const EdgeInsets.only(top: 15),
               width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height/20,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: context.theme.dialogBackgroundColor,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: tabs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                left: index == 0 ? MediaQuery.of(context).size.width/8 : MediaQuery.of(context).size.width/3, top: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      current = index;
                                       _taskController.getTask();
                                       _noteController.getNote();
                                    });
                                  },
                                  child: Text(
                                    tabs[index],
                                    style: GoogleFonts.ubuntu(
                                      fontSize: current == index ? 14 : 14,
                                      fontWeight: current == index
                                          ? FontWeight.w400
                                          : FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    curve: Curves.fastLinearToSlowEaseIn,
                    bottom: 0,
                    left: changePositionedOfLine(),
                    duration: const Duration(milliseconds: 1000),
                    child: AnimatedContainer(
                      margin: const EdgeInsets.only(left: 0),
                      width: changeContainerWidth(),
                      height: 2,
                      decoration: BoxDecoration(
                        color:  Get.isDarkMode?Colors.white:Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.fastLinearToSlowEaseIn,
                    ),
                  )
                ],
              ),
            ),
          const SizedBox(height: 10,),
          current==0? _showTask(): _showNote(),
        ],
        
      ),
      endDrawer: _sidebarDrawer(context),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () async {
          //TODO update pig
          await Get.to(()=>const pigUpdate());
          // _pigController.getPig();      
          PigController.to.getPig();  
          },
        elevation: 8,
        backgroundColor: Get.isDarkMode?primaryClr:Colors.white,
        child: Get.isDarkMode? const CircleAvatar(
          backgroundColor: primaryClr ,
          backgroundImage:AssetImage('images/logo2.png'),
        )
        :const CircleAvatar(
            backgroundColor: Colors.white  ,
            backgroundImage:AssetImage('images/logo1.png'),
           
        )
        
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
        shadowColor: primaryClr,
        shape: const CircularNotchedRectangle(),
          height: MediaQuery.of(context).size.height/11,
          color:   Get.isDarkMode?primaryClr:Colors.white,
          notchMargin: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () async {
                    await Get.to(() => const AddTaskPage());
                   const notif();
                    _taskController.getTask();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notification_add_outlined,
                         color: Get.isDarkMode?Colors.white:primaryClr,
                        ),
                        Text(
                          'Jadwal',
                          style: subStyle.copyWith(color: Get.isDarkMode?Colors.white:Colors.black,),
                        )
                      ],
                    ),
                  )
                ],
              ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: ()async {
                      await Get.to(()=>const AddNote());
                       const notif();
                      _noteController.getNote();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_note_rounded ,
                          color: Get.isDarkMode?Colors.white:primaryClr,
                        ),
                        Text(
                          'Catatan',
                          style: subStyle.copyWith(color: Get.isDarkMode?Colors.white:Colors.black,),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
            
          ),
          
        ),
    );
    
  }

  Drawer _sidebarDrawer(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            profilHeader(
              profilModel: profil,
            ),
            ListTile(
              leading: const Icon(Icons.health_and_safety),
              title: const Text("Kesehatan Babi"),
              onTap: () async {
                await Get.to(() => const pigHealth());
              },
            ),
            ListTile(
              leading: const Icon(Icons.data_exploration_rounded),
              title: const Text("Diagram Rekap"),
              onTap: () async {
                await DBHelper.sumGroup();
                await Get.to(() => const dataDiagram());
                  _pakanController.getPakan();
                  
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_pin_circle_outlined),
              title: const Text("Tentang Pengembang"),
              onTap: () async {
                await Get.to(() => const About());
              },
            ),
            ListTile(
              leading: const Icon(Icons.backup_table_sharp),
              title: const Text("Backup dan Restore"),
              onTap: () async {
                await Get.to(() => const backupRestoreData(
                      title: "",
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Keluar"),
              onTap: () {
                exit(0);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _packageInfoText != null
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      )
                    : Container(),
                _packageInfoText != null
                    ? Text(_packageInfoText!,
                        style: subtitle.copyWith(color: Colors.black))
                    : Container(),
                // Text('Versi Aplikasi 1.1.0',style: subtitle.copyWith(color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }
 _showNote(){
  if(_noteController.noteList.isEmpty){
      return Center(
        child: SizedBox(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                width: MediaQuery.of(context).size.width/5,
                child: Image.asset('images/empy.png')
                ),
          
                Container(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/100,),
                  child: Text('Catatan Ternak Kosong',style: subtitle.copyWith(color:Get.isDarkMode?Colors.white:Colors.grey,fontSize: 17, ),)),
                Container(
                  width: MediaQuery.of(context).size.width/1.3,
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/100,),
                  child: Text('Ayo buat catatan ternak anda\nmulai sekarang.',style: subtitle.copyWith(color:Get.isDarkMode?Colors.white:Colors.grey,fontSize: 12, ),textAlign: TextAlign.center,)),
               ],
            
          ),
        )
       ,);
    }
    else{
   return Expanded(
     child: Obx((){
        return ListView.builder(
          itemCount: _noteController.noteList.length,
          
         
           itemBuilder: (_, indexn){
      
            Note note = _noteController.noteList[indexn];
            
            print(note.toJson());
             if(note.repeat=="Harian"){
             DateTime date = DateFormat.Hm().parse(note.startTime.toString());
             var myTime = DateFormat("HH:mm").format(date);
             notifyHelper.notescheduledNotification(
              int.parse(myTime.toString().split(":")[0]),
              int.parse(myTime.toString().split(":")[1]),
              note 
             );

                return AnimationConfiguration.staggeredList(
                position: indexn, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showButtonSheetNote(context, note);
                          },
                          child: NoteTile(note),
                        )
                      ],
                    ),
                    
                  ),
                )
                );
             }
               if(note.repeat=="Mingguan"){
                return AnimationConfiguration.staggeredList(
                position: indexn, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showButtonSheetNote(context, note);
                          },
                          child: NoteTile(note),
                        )
                      ],
                    ),
                    
                  ),
                )
                );
             }
             if(note.date==DateFormat.yMd().format(_selectedDate)){
                 return AnimationConfiguration.staggeredList(
                position: indexn, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showButtonSheetNote(context, note);
                          },
                          child: NoteTile(note),
                        )
                      ],
                    ),
                    
                  ),
                )
                );
             }else{
                return Container();
             }
           
          });
          
          
     }),
     
    );
 } 
 }
_showTask(){
   if(_taskController.taskList.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            Container(
               margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/30),
                width: MediaQuery.of(context).size.width/5,
              child: Image.asset('images/empy.png')
              ),

              Container(
                 padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/100,),
                child: Text('Jadwal Ternak Kosong',style: subtitle.copyWith(color:Get.isDarkMode?Colors.white:Colors.grey,fontSize: 17, ),)),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                 padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/100,),
                child: Text('Ayo buat jadwal ternak anda\nmulai sekarang.',style: subtitle.copyWith(color:Get.isDarkMode?Colors.white:Colors.grey,fontSize: 12, ),textAlign: TextAlign.center,)),
             ],
          
        )
       ,);
    }else{
    return Expanded(
     child: Obx((){
        return ListView.builder(
          itemCount: _taskController.taskList.length,

           itemBuilder: (_, index){
      
            Task task = _taskController.taskList[index];
            
            print(task.toJson());
            // print(_noteController.noteList.length);
            //menampilkan database yang sudah di inputkan
             if(task.repeat=="Harian"){
             DateTime date = DateFormat.Hm().parse(task.startTime.toString());
             var myTime = DateFormat("HH:mm").format(date);
             notifyHelper.scheduledNotification(
              int.parse(myTime.toString().split(":")[0]),
              int.parse(myTime.toString().split(":")[1]),
              task 
             );

                return AnimationConfiguration.staggeredList(
                position: index, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showButtonSheet(context, task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                    
                  ),
                )
                );
             }
             if(task.repeat=="Mingguan"){
             DateTime date = DateFormat.Hm().parse(task.startTime.toString());
             var myTime = DateFormat("HH:mm").format(date);
             notifyHelper.scheduledNotification(
              int.parse(myTime.toString().split(":")[0]),
              int.parse(myTime.toString().split(":")[1]),
              task 
             );

                return AnimationConfiguration.staggeredList(
                position: index, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showButtonSheet(context, task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                    
                  ),
                )
                );
             }

             if(task.date==DateFormat.yMd().format(_selectedDate)){
                 return AnimationConfiguration.staggeredList(
                position: index, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showButtonSheet(context, task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                    
                  ),
                )
                );
             }else{
                return Container();
             }
             
           
          });
          
          
     }),
     
    );
    
    }
  }
   showButtonSheetNote(BuildContext context, Note note){
    Get.bottomSheet(
      Container(//menambah bagian saat ditekn warna putih
        padding: const EdgeInsets.only(top: 4),
        height: note.isCompleted==1?
        MediaQuery.of(context).size.height*0.20:
        MediaQuery.of(context).size.height*0.25,
        decoration: BoxDecoration(
         color: Get.isDarkMode? darkGreyClr:Colors.white,
         border: Border.all(color:Get.isDarkMode? darkGreyClr:Colors.white,),
         borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
         ),
        
        child: Column(
          children: [
            Container(
              height: 5,
              width: 120,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
              ),
            ),
          const Spacer(),
          note.isCompleted==1
          ?Container():
            // : _buttonSheetButton(
            //   label: "Task Completed",
            //    onTap: (){
            //     Get.back();
            //     _noteController.markNoteCompleted(note.id!);
            //     _validateButtonCompleted();
        
            //    },
            //    clr: primaryClr,
            //    context:context,
            //    ),
            //   ,
                _buttonSheetButton(
                  label: "Delete",
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                          title: const Text("Apakah anda yakin ingin menghapus data ini ?"),
                          actions: [
                        Column(
                            children: [
                            TextButton(
                                  child: const Text('Batal'),
                            onPressed: () => Get.back()
                          ),
                            ],
                          ),
                        Column(
                          children: [
                            TextButton(
                                  child: const Text('Ya'),
                            onPressed: (){
                              Get.back();
                              Get.back();
                              _noteController.deletenote(note);
                              _validateButtonDelete();
                             } 
                            ),
                            ],
                          )                         
                        ],  
                                  
                      ),
                      
                  );
                
                  },
                  clr: Colors.red[300]!,
                  context:context,
               ),
                const SizedBox(
                  height: 10,
                ),
               _buttonSheetButton(
                  label: "Close",
                  onTap: (){
                    Get.back();
                  },
                 clr: primaryClr,
                  isColese: true,
                  context:context,
               ),
 
          ],
        ),
      )
    );
  }
  showButtonSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(//menambah bagian saat ditekn warna putih
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted==1?
        MediaQuery.of(context).size.height*0.20:
        MediaQuery.of(context).size.height*0.25,
        decoration: BoxDecoration(
         color: Get.isDarkMode? darkGreyClr:Colors.white,
         border: Border.all(color:Get.isDarkMode? darkGreyClr:Colors.white,),
         borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
         ),
        
        child: Column(
          children: [
            Container(
              height: 5,
              width: 120,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
              ),
            ),
          const Spacer(),
          task.isCompleted==1
          ?Container()
            : _buttonSheetButton(
              label: "Task Completed",
               onTap: (){
                Get.back();
                _taskController.markTaskCompleted(task.id!);
                _validateButtonCompleted();
        
               },
               clr: primaryClr,
               context:context,
               ),
              
                _buttonSheetButton(
                  label: "Delete",
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                          title: const Text("Apakah anda yakin ingin menghapus data ini ?"),
                          actions: [
                        Column(
                            children: [
                            TextButton(
                            child: const Text('Batal'),
                            onPressed: () => Get.back()
                          ),
                            ],
                          ),
                        Column(
                          children: [
                            TextButton(
                            child: const Text('Ya'),
                            onPressed: (){
                              Get.back();
                               Get.back();
                              _taskController.delete(task);
                              _validateButtonDelete();
                             } 
                            ),
                            ],
                          )                         
                        ],            
                      ),
                  );
                  
                  },
                  clr: Colors.red[300]!,
                  context:context,
               ),
                const SizedBox(
                  height: 10,
                ),
               _buttonSheetButton(
                  label: "Close",
                  onTap: (){
                    Get.back();
                  },
                 clr: primaryClr,
                  isColese: true,
                  context:context,
               ),
 
          ],
        ),
      )
    );
  }

  
_buttonSheetButton({
required String label, 
  required Function()? onTap,
  required Color clr,
  bool isColese=false,
  required BuildContext context,
}){
  return GestureDetector(
    onTap:onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4, ),
      height: 50,
      width: MediaQuery.of(context).size.width*0.7,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isColese==true?Get.isDarkMode?primaryClr:primaryClr:clr,


        ),
        borderRadius: BorderRadius.circular(20),
         color: isColese==true?Colors.transparent:clr,
      ),
      
      child: Center(//agar ditengah tulisannya
        child: Text(
          label,
          style: isColese?titleStyle:titleStyle.copyWith(color: Colors.white),
        ),
      ),

 )
  );
}


  _addDateBar(){
    return   Container(
          margin: const EdgeInsets.only(top:0, left: 20, right: 20),
       
          child: DatePicker(
          DateTime.now(),
          // DateTime.utc(2023,9,1),
           height: 85,
            width: 80,
            locale: 'id',

            initialSelectedDate: DateTime.now(),
            selectionColor: primaryClr,
            selectedTextColor: Colors.white,
            dateTextStyle: GoogleFonts.lato(
             textStyle: const TextStyle(
              fontSize: 18,
              fontWeight:  FontWeight.w600,
              color:  Colors.grey
             )
            ),
            dayTextStyle: GoogleFonts.lato(
             textStyle: const TextStyle(
               fontSize: 14,
              fontWeight:  FontWeight.w600,
              color:  Colors.grey
             )
            ),
            monthTextStyle: GoogleFonts.lato(
             textStyle: const TextStyle(
               fontSize: 13,
              fontWeight:  FontWeight.w600,
              color:  Colors.grey
             )
            ),
            
            onDateChange: (date){
             setState(() {
                _selectedDate=date;
             });
            },
          ),
          
         );
         
  }
  _addTaskBar(){
     return Column(
       children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 21),
                  width: MediaQuery.of(context).size.width,
                  child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              _headerDataTernak(),
                     
                Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: bgClr,
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(1.5, 0)
                            )
                          ],
                    color: primaryClr,
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                          )
                        ),
                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                    _titleDataTernak(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    _totalDataTernak()
                  ],
                ),
              ),
                      
            ],
          ),
        ),
      ],
    );
  }

  _totalDataTernak() {
    return GetBuilder(
      builder: (PigController pigController) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 38,
          width: MediaQuery.of(context).size.width / 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 22,
              ),
              Expanded(
                child: Text(
                  // '$totall',
                  pigController.totalIndukan.value.toString(),
                  style: subStyle.copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: Text(
                    // '$totalAnakan',
                    pigController.totalAnakan.value.toString(),
                    style: subStyle.copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 12,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: Text(
                    // '$totalPengemukan',
                    pigController.totalPengemukan.value.toString(),
                    style: subStyle.copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 10,
              ),
              Expanded(
                child: Text(
                  // '$totalPejantan',
                  pigController.totalPejantan.value.toString(),
                  style: subStyle.copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  SizedBox _titleDataTernak() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 20,
      width: MediaQuery.of(context).size.width / 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 33,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Text(
              "Indukan",
              style: subStyle.copyWith(color: Colors.white, fontSize: 12),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 5.2,
            child: Text(
              "Anakan",
              style: subStyle.copyWith(color: Colors.white, fontSize: 12),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
            child: Text(
              "Penggemukan",
              style: subStyle.copyWith(color: Colors.white, fontSize: 12),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: Text(
              "Pejantan",
              style: subStyle.copyWith(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Container _headerDataTernak() {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: bgClr,
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(1.5, 0))
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hari ini",
                  style: headingStyle,
                ),
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.white,
                    // margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    //height: MediaQuery.of(context).size.height/17,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Total Ternak',
                          style: headingStyle.copyWith(fontSize: 13),
                        ),
                        Obx(() => Text(
                              // '${count(
                              //   totall +
                              //       totalPejantan +
                              //       totalPengemukan +
                              //       totalAnakan,
                              // )}',
                              // 'TODO total',
                              // _pigController
                              PigController.to
                                  .calculateAllTotalTernak()
                                  .toString(),
                              style: subHeadingStyle,
                            )),
                      ],
                    )),
              ],
            )
          ],
        ));
  }
  _appBar(){
    return AppBar(
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height/15,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20),)
        ),
      ),
      leading: GestureDetector(
        onTap: (){
              // notifyHelper._postNotification();
              ThemeService().switchTheme();
              notifyHelper.displayNotification(
                title : "Tema Berubah",
                body : Get.isDarkMode?"Mode Terang Aktif":"Mode Gelap Aktif"
              );
              //notifyHelper.scheduledNotification();
                
        },
        
        child: Icon(Get.isDarkMode  ? Icons.wb_sunny_outlined: Icons.nightlight_round,
        size: 20,
        color: Get.isDarkMode ? Colors.white:Colors.black
        
        ),
       ),
      
    );
  }
  
  _validateButtonCompleted(){
    Get.snackbar("Sukses", "Jadwal Berhasil Diselesaikan",
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
      icon: const Icon(
        Icons.beenhere_outlined,
        color: primaryClr,
      ),
    colorText: primaryClr,
    );  
  }
_validateButtonDelete(){
    Get.snackbar("Sukses", "Jadwal Berhasil Dihapus",
    snackPosition:  SnackPosition.values.first,
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
_getInfoPressed() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    setState(() {
      _packageInfoText = "Versi Aplikasi: $version\n";
    });
  }

} 
