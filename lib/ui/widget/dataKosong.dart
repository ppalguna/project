import 'package:flutter/material.dart';


class getDataKosong extends StatelessWidget {
  const getDataKosong({super.key});

  @override
  Widget build(BuildContext context) {
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
             ],
          
        )
       ,);
  }
}