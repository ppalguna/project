import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key, 
    required this.nama,
     required this.namaFarm,
  });
  final String nama, namaFarm;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(CupertinoIcons.person,color: Colors.white),
      ),
      //texk nama
      title: Text(
        nama,
        style: const TextStyle(
         fontSize: 15,
         fontWeight:  FontWeight.w600,
         color:  Colors.white
        ),
        ),
        subtitle: Text(
          namaFarm,
           style: const TextStyle(
         fontSize: 13,
         fontWeight:  FontWeight.w600,
         color:  Colors.white
        ),),
    );
  }
}