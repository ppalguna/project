import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/models/note.dart';
import 'package:my_piggy_app/ui/theme.dart';

class detailNote extends StatelessWidget {
  final Note? note;
  const detailNote(this.note, {super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        
        title: 
        Text('Detail Catatan ', style: subStyle.copyWith( color: Get.isDarkMode?Colors.white:Colors.black,),),
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
                height: MediaQuery.of(context).size.height/20,
                width: MediaQuery.of(context).size.width/1.1,
              ),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/1.1,
                    decoration:  BoxDecoration(
                      color: _getBGClr(note?.color??0),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0 , 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              padding:const EdgeInsets.only(top: 20),
                                child: note?.image != null? Container(
                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                // border: Border.all(
                                // color: Colors.grey,
                                // width: 3
                                // )
                              ),
                              width:MediaQuery.of(context).size.width/1.5, 
                              height: MediaQuery.of(context).size.height/4.3,
                              child: Image.memory(note!.image!, fit: BoxFit.cover,))
                              :
                              Container(
                              ),
                          

                            ),
                           Container(
                              padding: const EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width/1.5,
                             child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(note?.judul??"",style: subtitle.copyWith(fontSize:20,color: Get.isDarkMode?Colors.white:Colors.black,),textAlign: TextAlign.start,),
                                  SizedBox(height: MediaQuery.of(context).size.height/80,),
                                  Text("Catatan : ${note?.keterangan??""}",style: subtitle.copyWith(fontSize: 13,color: Get.isDarkMode?Colors.white:Colors.white,),),
                                   SizedBox(height: MediaQuery.of(context).size.height/100,),
                                  Text("Tanggal : ${note?.date??""}",style: subtitle.copyWith(fontSize: 13,color: Get.isDarkMode?Colors.white:Colors.white,),),
                                   SizedBox(height: MediaQuery.of(context).size.height/100,),
                                  Text("Waktu : ${note?.startTime??""}-${note?.endTime??""}",style: subtitle.copyWith(fontSize: 13,color: Get.isDarkMode?Colors.white:Colors.white,),),
                                  
                                ],
                              ),
                           ),
                            

                          ],
                          
                        ),
                        
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