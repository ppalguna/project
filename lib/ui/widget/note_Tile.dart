import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_piggy_app/ui/widget/detail_note.dart';
import 'package:my_piggy_app/ui/widget/edit_note.dart';

//import 'package:my_piggy_app/ui/widget/notified_page.dart';

import '../../models/note.dart';
import '../theme.dart';


class NoteTile extends StatelessWidget {
  final Note? note;
  const NoteTile(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(note?.color??0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
             Container(
                      width: MediaQuery.of(context).size.width/2.5,
                      //height: MediaQuery.of(context).size.height/33,
                      decoration:const BoxDecoration(
                         color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child:  Text(
                      "CATATAN",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                    ),
                    ),
            Row(children: [
              
              Expanded(
                
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       
                    Text(
                      note?.judul??"",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          // Icons.access_time_rounded,
                           Icons.date_range_outlined,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text('${note!.date}',
                          // "${note!.startTime} - ${note!.endTime}",
                          style: GoogleFonts.lato(
                            textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      note?.keterangan??"",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
              ),        
               Column(
                 children: [
                   Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         note?.image != null? Container(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: const BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.all(Radius.circular(10)),
                             // border: Border.all(
                             // color: Colors.grey,
                             // width: 3
                             // )
                           ),
                         width:MediaQuery.of(context).size.width/3.5, 
                         height: MediaQuery.of(context).size.height/8.3,
                          child: Image.memory(note!.image!, fit: BoxFit.cover,))
                          :
                          Container(
                           ),
                      
                       ],
                     ),
               note?.image != null?  Row(
                 children: [
                   IconButton(
                    onPressed:  ()async {
                              await Get.to(()=>editNote(noteModel:note,));
                             },
                    icon: const Icon(
                    Icons.edit_note,
                    color: Colors.white,
                   ),
                  ),
                  IconButton(
                    onPressed:  ()async {
                          await Get.to(()=>detailNote(note));
                            },
                    icon: const Icon(
                    Icons.grid_view_rounded,
                    color: Colors.white,
                  ),
                  ),
                 ],
               ):Column(
                 children: [
                   IconButton(
                    onPressed:  ()async {
                             await Get.to(()=>editNote(noteModel:note,));
                              
                             },
                    icon: const Icon(
                    Icons.edit_note,
                    color: Colors.white,
                   ),
                  ),
                  IconButton(
                    onPressed:  ()async {
                                await Get.to(()=>detailNote(note));
                            },
                    icon: const Icon(
                    Icons.grid_view_rounded,
                    color: Colors.white,
                  ),
                  ),
                 ],
               )
                 ],
               ), 
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   height: 60,
              //   width: 0.5,
              //   color: Colors.grey[200]!.withOpacity(0.7),
              // ),
              
              // RotatedBox(
              //   quarterTurns: 3,
              //   child: Text(
              //     note!.isCompleted == 1 ? "SELESAI" : "TERSEDIA",
              //     style: GoogleFonts.lato(
              //       textStyle: const TextStyle(
              //           fontSize: 12,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white),
              //     ),
              //   ),
              // ),
             
            ]),
          ],
        ),
        
      ),
      
    );
    
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
}