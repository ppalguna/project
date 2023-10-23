import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_piggy_app/ui/theme.dart';

class MyBotton extends StatelessWidget {
  final String label;
  final Function ()? onTap;
  const MyBotton({Key? key,required this.label,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      
      child: Container(
        margin: const EdgeInsets.only(top:10, right:20, bottom: 30),
        padding : const EdgeInsets.only(top: 20, left: 35),//padding tulisan pada button add
        width: 130,
        height: 60,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryClr,
          boxShadow: [
                  BoxShadow(
              color: const Color.fromARGB(255, 7, 0, 97).withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 1.5,
              offset: const Offset(0, 0),
                  )
                ],
        ),
      child: Text(
        label,
       
        style: GoogleFonts.lato (
          color: Colors.white,
          fontSize: 16,
          
          
          
        ),
      ),
      ),
    );
  }
}