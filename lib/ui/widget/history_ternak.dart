import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/controllers/pakan_controller.dart';
import 'package:my_piggy_app/models/pakan.dart';
import 'package:my_piggy_app/ui/widget/pakan_tile.dart';
import 'package:my_piggy_app/ui/widget/pig_tile.dart';

import '../../controllers/pig_controller.dart';
import '../../models/pig.dart';
import '../theme.dart';

class historyTernak extends StatefulWidget {
  const historyTernak({super.key});

  @override
  State<historyTernak> createState() => _historyTernakState();
}

class _historyTernakState extends State<historyTernak> {
  final _pigControler=Get.put(PigController());
  final _pakanController=Get.put(PakanController());
  List<String> tabs = [
    "Ternak",
    "Pakan",
    
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
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        
        title: 
        Text('Histori Pakan & Ternak', style: subStyle.copyWith( color: Get.isDarkMode?Colors.white:Colors.black,),),
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: context.theme.dialogBackgroundColor,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode?Colors.white:Colors.black,
          
        ),
    
      ),
      backgroundColor: context.theme.dialogBackgroundColor,
      body: Column(
            children: [ 
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
                                left: index == 0 ? MediaQuery.of(context).size.width/6 : MediaQuery.of(context).size.width/2.5, top: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      current = index;
                                       _pigControler.getPig();
                                      _pakanController.getPakan();
                                    });
                                  },
                                  child: Text(
                                    tabs[index],
                                    style: subtitle.copyWith(color: Get.isDarkMode?Colors.white:Colors.black,),
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
          current==0? _showPig(): _showPakan(),
             ],
      )
  );
  }

  _showPig(){
    if(_pigControler.pigList.isEmpty){
      return Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
              width: MediaQuery.of(context).size.width/3,
              child: Image.asset('images/empy.png')
              ),

              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Data Ternak Kosong',style: subtitle.copyWith(color:Get.isDarkMode?Colors.white:Colors.grey,fontSize: 17, ),)),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                padding: const EdgeInsets.only(top: 7),
                child: Text('Ayo tambahkan data ternak anda\nmulai sekarang.',style: subtitle.copyWith(color:Get.isDarkMode?Colors.white:Colors.grey,fontSize: 12, ),textAlign: TextAlign.center,)),
             ],
          
        )
       ,);
    }else{
    return Expanded(
      child: Obx((){
        return ListView.builder(
          itemCount: _pigControler.pigList.length,
          itemBuilder:(_, context){
            Pig pig = _pigControler.pigList[context];
            print(pig.toJson());
            print(_pigControler.pigList.length);
           return AnimationConfiguration.staggeredList(
                position: context, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          
                          child: PigTile(pig),
                        )
                      ],
                    ),
                    
                  ),
                )
                );
          });
      }),
    );
  }
  }
 _showPakan(){
  if(_pakanController.pakanList.isEmpty){
       return Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
              width: MediaQuery.of(context).size.width/3,
              child: Image.asset('images/empy.png')
              ),

              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Data pakan kosong',style: subtitle.copyWith(color:Get.isDarkMode?Colors.white:Colors.grey,fontSize: 17, ),)),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                padding: const EdgeInsets.only(top: 7),
                child: Text('Ayo tambahkan data pakan ternak \nanda mulai sekarang.',style: subtitle.copyWith(color:Get.isDarkMode?Colors.white:Colors.grey,fontSize: 12, ),textAlign: TextAlign.center,)),
             ],
          
        )
       ,);
    }else{
    return Expanded(
      child: Obx((){
        return ListView.builder(
          
          itemCount: _pakanController.pakanList.length,
          itemBuilder:(_, context){
            Pakan pakan = _pakanController.pakanList[context];
            print(pakan.toJson());
            print(_pakanController.pakanList.length);
           return AnimationConfiguration.staggeredList(
                position: context, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          
                          child: PakanTile(pakan),
                        )
                      ],
                    ),
                    
                  ),
                )
                );
          });
      }),
    );
  }
 }
}
