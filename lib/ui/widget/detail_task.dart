import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/ui/theme.dart';

import '../../models/task.dart';
import 'time_line.dart';

class detail extends StatelessWidget {
  final Task? task;
  const detail(this.task, {super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        
        title: 
        Text('Detail Penjadwalan ', style: subStyle.copyWith( color: Get.isDarkMode?Colors.white:Colors.black,),),
        bottomOpacity: 0.0,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: context.theme.dialogBackgroundColor,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode?Colors.white:Colors.black,
          
        ),
    
      ),
      body:SingleChildScrollView(
        child: Container(
          color: context.theme.dialogBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/12,
                width: MediaQuery.of(context).size.width/1.1,
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text(task?.title??"",
                    style: subtitle.copyWith(
                    fontSize:20,color: Get.isDarkMode?Colors.white:Colors.black,),textAlign: TextAlign.start,),
                    Row(
                      children: [
                        Text("Catatan : ",style: subtitle.copyWith(fontSize: 13,color: Get.isDarkMode?Colors.white:bgClr,),),
                        Text(task?.note??"",
                        style: subtitle.copyWith(
                        fontSize:13,color: Get.isDarkMode?Colors.white:bgClr,),textAlign: TextAlign.start,),
                      ],
                    ),
                     Row(
                      children: [
                        Text("Dibuat pada : ",style: subtitle.copyWith(fontSize: 13,color: Get.isDarkMode?Colors.white:bgClr,),),
                        Text(task?.date??"",
                        style: subtitle.copyWith(
                        fontSize:13,color: Get.isDarkMode?Colors.white:bgClr,),textAlign: TextAlign.start,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/60,),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/1.25,
                    decoration:  BoxDecoration(
                      color: _getBGClr(task?.color??0),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0 , 0, 0),
                      child: ListView(
                        children:  [
                          TimeLine(isFirst: true,
                           isLast: false, 
                           isPast: true,
                          event:  Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height/7,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  padding: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                  color: context.theme.dialogBackgroundColor, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                  shape: BoxShape.rectangle,
                                ),
                                child: SingleChildScrollView(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 20, 0, 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Tanggal Babi Kawin : ${task?.date??""}",style: subtitle.copyWith(fontSize: 13,color: context.theme.dialogBackgroundColor),),
                                    Text("\nCatatan : \nKawin dinyatakan berhasil apabila selama kurang lebih 15 hari setelah dikawinkan tidak menunjukan tanda tanda birahi pada indukan. ", style: subtitle.copyWith(fontSize: 10, color: context.theme.dialogBackgroundColor),),
                                  ],
                                                              ),
                                ),
                              ),
                              
                              Positioned(
                                left: 5,
                                top: 12,
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 5, left:5, right: 5,top: 5),
                           
                                  decoration: BoxDecoration(
                                   color: context.theme.dialogBackgroundColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Text("Waktu Kawin Indukan", 
                                style: subtitle.copyWith(fontSize: 13, color:  Get.isDarkMode?Colors.white: bgClr,),)
                                
                                ),
                              ),
                            ],
                            
                          ),
                          ),
                          TimeLine(isFirst: false, 
                          isLast: false, 
                          isPast: true,
                          event: Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height/7,
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                padding: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                  color: context.theme.dialogBackgroundColor, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                  shape: BoxShape.rectangle,
                                ),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: MediaQuery.of(context).size.width/50,),
                                    Text("Perkiraan lahir : ${task?.tanggalLahir??""} ",style: subtitle.copyWith(fontSize: 13,color: context.theme.dialogBackgroundColor),),
                                   //${tempDate.add(Duration(days: 114))} sampai ${tempDate.add(Duration(days: 117))}
                                    Text("\nCatatan : \n« Masa bunting babi antara 114 hari sampai 117 hari." 
                                    "\n« Siapkan alat untuk anakan babi lahir seperti gunting, lap, bedak, dan alat kesehatan seperti betadine."
                                    "\n« Anakan yang baru lahir disuntikan"
                                    " dengan zat besi misalnya suntikan Ferdex."
                                    "\n« Dilakukannya pemotongan gigi agar puting indukan tidak terluka.", style: subtitle.copyWith(fontSize: 10, color: context.theme.dialogBackgroundColor),),
                                  ],
                                                      ),
                                ),
                              ),
                              
                              Positioned(
                                left: 5,
                                top: 12,
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 5, left:5, right: 5,top: 5),
                           
                                  decoration: BoxDecoration(
                                   color: context.theme.dialogBackgroundColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Text("Perkiraan Babi Lahir", 
                                style: subtitle.copyWith(fontSize: 13, color: Get.isDarkMode?Colors.white: bgClr),)
                                
                                ),
                              ),
                            ],
                            
                          ),
                          
                          ),
                          TimeLine(isFirst: false, 
                          isLast: false, 
                          isPast: true,
                          event:  Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height/1,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                  color: context.theme.dialogBackgroundColor, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                  shape: BoxShape.rectangle,
                                ),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height/50,),
                                     Text("Tanggal Kebiri : ${task?.tanggalKebiri??''}",style: subtitle.copyWith(fontSize: 13,color: context.theme.dialogBackgroundColor),),
                                     Text("\nCatatan : \n« Anakan babi jantan dikebiri saat berusia antara 15 sampai 20 hari tergantung ukuran testis anakan babi. "
                                     "\n« Setelah kebiri anakan diberikan suntukan vitamin "
                                     "\n« Anakan babi sudah bisa diberikan pakan kering sedikt demi sedikit.", style: subtitle.copyWith(fontSize: 10, color: context.theme.dialogBackgroundColor),),
                                  ],
                                                      ),
                                ),
                              ),
                              
                              Positioned(
                                left: 5,
                                top: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 5, left:5, right: 5,top: 5),
                           
                                  decoration: BoxDecoration(
                                   color: context.theme.dialogBackgroundColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Text("Perkiraan kebiri", 
                                style: subtitle.copyWith(fontSize: 13, color: Get.isDarkMode?Colors.white: bgClr),)
                                
                                ),
                              ),
                            ],
                            
                          ),),
                           TimeLine(isFirst: false, 
                          isLast: true, 
                          isPast: false,
                          event:  Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height/7,
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                padding: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                  color: context.theme.dialogBackgroundColor, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                  shape: BoxShape.rectangle,
                                ),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: MediaQuery.of(context).size.width/50,),
                                    Text("Sapih : ${task?.tanggalSapih??''}", style: subtitle.copyWith(fontSize: 13, color: context.theme.dialogBackgroundColor),),
                                    Text('\nCatatan : \n« Anakan babi dapat disapih mulai umur 4 sampai 5 minggu'
                                    '\n« Saat sapih harus diberikan vaksin agar daya tahan tubuh anakan babi yang akan di sapih menjadi lebih kuat',style: subtitle.copyWith(fontSize: 10, color: context.theme.dialogBackgroundColor))
                                  ],
                                                      ),
                                ),
                              ),
                              
                              Positioned(
                                left: 5,
                                top: 12,
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 5, left:5, right: 5,top: 5),
                           
                                  decoration: BoxDecoration(
                                   color: context.theme.dialogBackgroundColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Text("Perkiraan Tanggal Sapih", 
                                style: subtitle.copyWith(fontSize: 13, color: Get.isDarkMode?Colors.white: bgClr),)
                                
                                ),
                              ),
                            ],
                            
                          ),),
                          
                        ],
                        
                      ),
                      
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      
    );
    
  }
}
 _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return greenClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }