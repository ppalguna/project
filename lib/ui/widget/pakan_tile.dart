import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/pakan.dart';
import '../theme.dart';

class PakanTile extends StatelessWidget {
  final Pakan? pakan;
  const PakanTile(this.pakan, {super.key});
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
          color: primaryClr,
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
                          'Tanggal Pakan : ',
                          style: subtitle.copyWith(fontSize: 10)
                        ),
                        const SizedBox(width: 4),
                         Text(
                          pakan?.tanggalPakan??"",
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
                          'Jumlah Pakan: ',
                          style: subtitle.copyWith(fontSize: 10)
                        ),
                        const SizedBox(width: 4),
                         Text(
                          pakan?.jumlahPakan.toString()??"",
                          style: subtitle.copyWith(fontSize: 15)
                        ),
                        Text(" Sak",
                          style: subtitle.copyWith(fontSize: 15)
                        ),
                     ],
                   ),
                 ],
               ),
                const SizedBox(
                  height: 5,
                ),
               
                Text(
                  'Catatan : ',
                  style: subtitle.copyWith(fontSize: 10)
                ),
                const SizedBox(width: 4),
                Text(
                  pakan?.catatanPakan??"",
                  style: subtitle.copyWith(fontSize: 15)
                   
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
         Text(NumberFormat.currency(name: 'id-ID', decimalDigits: 0, symbol: 'Rp. ').format(pakan?.hargaPakan),
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
        ]),
        
      ),
      
    );
    
  }

}