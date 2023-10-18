import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_piggy_app/models/pig.dart';

import '../theme.dart';


class PigTile extends StatelessWidget {
  final Pig? pig;
  const PigTile(this.pig, {super.key});
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
          color: _getBGClr(pig?.color??0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2.5,
                  //height: MediaQuery.of(context).size.height/33,
                  decoration: const BoxDecoration(
                     color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  
                ),
               Column(
                 children: [
                   Row(
                     children: [
                       Text(
                          'Tanggal : ',
                          style: subtitle.copyWith(fontSize: 10)
                        ),
                        const SizedBox(width: 4),
                         Text(
                          pig?.tanggal??"",
                          style: subtitle.copyWith(fontSize: 15)
                        ),
                     ],
                   ),
                    const SizedBox(
                  height: 5,
                ),
                   Row(
                     children: [
                       Text(
                          'Jenis Ternak : ',
                          style: subtitle.copyWith(fontSize: 10)
                        ),
                        const SizedBox(width: 4),
                         Text(
                          pig?.jenisTernak??"",
                          style: subtitle.copyWith(fontSize: 15)
                        ),
                     ],
                   ),
                 ],
               ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Tipe ",
                   style: subtitle.copyWith(fontSize: 10)),
                    const SizedBox(width: 4),
                    Text(
                      pig?.tipeUpdate??"",
                      style: subtitle,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Catatan : ',
                  style: subtitle.copyWith(fontSize: 10)
                ),
                // ignore: prefer_const_constructors
                SizedBox(width: 4),
                Text(
                  pig?.catatanPig??"",
                  style: subtitle.copyWith(fontSize: 10)
                   
                ),
              ],
            ),
          ),        
          
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          
          RotatedBox(
            quarterTurns: 0,
            child: Text(
              pig?.jumlah.toString()??"",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
         Text(" Ekor",
          style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
          )
         )
        ]),
        
      ),
      
    );
    
  }
// _validateButtonDeletePig(){
//     Get.back();
//     Get.snackbar("Sukses", "Jadwal Berhasil Dihapus",
//     snackPosition:  SnackPosition.BOTTOM,
//     backgroundColor: primaryClr,
//       icon: const Icon(
//         Icons.beenhere_outlined,
//         color: Colors.white,
//       ),
//     colorText: Colors.white,
//     );  
  
//   }
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