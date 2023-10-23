import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/ui/theme.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class About extends StatelessWidget {
  const About({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Tentang Pengembang', style: subStyle.copyWith(color: Get.isDarkMode?Colors.white:Colors.black,),),
        backgroundColor: context.theme.dialogBackgroundColor,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode?Colors.white54:Colors.black,
          
        ),
      ),
    
    backgroundColor: context.theme.dialogBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        
          Container(
          width:  double.infinity,
          height:MediaQuery.of(context).size.height/1.2,
          padding: const EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(
            color: primaryClr,
             borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                height: MediaQuery.of(context).size.height/8,
                decoration:  const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                  image: AssetImage('images/myfoto.jpg')
                ),   
                ), 
              ),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
               Column(
            children: [
              Text("TENTANG", style: subtitle.copyWith(fontSize: 17),),
              Container(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: Text("I Putu Palguna mahasiswa Institut Teknologi dan Bisnis STIKOM Bali"
                ", Program Studi Sistem Komputer, dengan Konsentrasi Networking and Cyber Sercurity ", style: subtitle.copyWith(fontSize: 12), textAlign: TextAlign.justify,)),
                  
              Text("SKILL", style: subtitle.copyWith(fontSize: 17),),
               Column(
                 children: [
                   Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 20, 50, 20),
                    child: Container(
                                      padding: const EdgeInsets.only(top: 5),
                      height: MediaQuery.of(context).size.height/35,
                      width: MediaQuery.of(context).size.width/3,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: bgClr
                      ),
                      child: Text("FLutter Developer", 
                      style: subtitle.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,)
                      )
                      
                    ),
                    Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 50, 20),
                    child: Container(
                                      padding: const EdgeInsets.only(top: 5),
                      height: MediaQuery.of(context).size.height/35,
                      width: MediaQuery.of(context).size.width/2,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: bgClr
                      ),
                      child: Text("Adobe Premier and Photoshop", 
                      style: subtitle.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,)
                      )
                      
                    ),
                 ],
               ),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              Text("KONTAK", style: subtitle.copyWith(fontSize: 17),),
              Container(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: Column(
                  children: [
                   Row(children: [
                    SizedBox(width: MediaQuery.of(context).size.width/200,),
                                      const Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/50,
                      height: MediaQuery.of(context).size.height/30,
                    ),
                    Text("ippalguna@gmail.com", 
                      style: subtitle.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,)
                   ],),
                   Row(children: [
                    SocialWidget(
                      placeholderText: 'pallgn_',
                      iconSize: 20,
                      iconData: SocialIconsFlutter.instagram,
                      iconColor: Colors.white,
                      link: 'https://www.instagram.com/pallgn_/',
                      placeholderStyle: subtitle.copyWith(color: Colors.white, fontSize: 12)
                      ,
                    ),
                   ],),
                   Row(children: [
                   SocialWidget(
                      placeholderText: 'I Putu Palguna',
                      iconSize: 20,
                      iconData: SocialIconsFlutter.linkedin_box,
                      iconColor: Colors.white,
                      link: 'https://www.instagram.com/pallgn_/',
                      placeholderStyle: subtitle.copyWith(color: Colors.white, fontSize: 12)
                      ,
                    ),
                   ],)
                  ],
                )
               ),
                //SizedBox(height: MediaQuery.of(context).size.height/15,),
                Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.copyright,
                            color: Get.isDarkMode?Colors.white:Colors.white,
                            size: 13,
                          ),
                           Text("ITB STIKOM Bali", style: subtitle.copyWith(fontSize: 12),  textAlign: TextAlign.center, )
                        ],
                      ),
            ],
          )
            ]
          )
          ),
         
        ],
      )
    );
  }
  cover()=>
    Image.asset('images/myfoto.jpg');
   myFoto(){
    return
    CircleAvatar(
      backgroundColor: primaryClr,
      child: Image.asset('images/myfoto.jpg'),
      
  );
  }
  
}