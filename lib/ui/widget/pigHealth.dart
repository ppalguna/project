import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../theme.dart';

class pigHealth extends StatefulWidget {
  const pigHealth({super.key});

  @override
  State<pigHealth> createState() => _pigHealthState();
}
class _pigHealthState extends State<pigHealth> {
  final List <String>imgList=[
     'images/ph1.jpg',
     'images/ph2.jpg',
     'images/ph3.jpg',
     'images/ph4.png',
     'images/ph01.jpg',
  ];
    final List <String>jenis=[
     'ph1.jpg',
     'ph2.jpg',
     'ph3.jpg',
     'ph4.png',
     'ph01.jpg',
  ];
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor:context.theme.dialogBackgroundColor,
        title: 
        Text('Kesehatan Babi', style: subStyle.copyWith(color: Get.isDarkMode? Colors.white:Colors.black,),textAlign: TextAlign.end,),
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode? Colors.white:Colors.black,
          
        ),
    
      ),
      
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: context.theme.dialogBackgroundColor,
          child:  SingleChildScrollView(
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/40,),
                Container(
                  color: context.theme.dialogBackgroundColor,
                  child: Column(
                    children: [
                     
                      Container( 
                      padding: const EdgeInsets.only(top: 0, bottom: 20),
                        width: double.infinity,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 1.9,
                            enlargeCenterPage: true
                          ),
                          items: imgList
                              .map((item) => Container(
                                    margin: const EdgeInsets.all(1.0),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: Stack(
                                          children: <Widget>[
                                            Image.asset(
                                              item,
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1,
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              left: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          200, 0, 0, 0),
                                                      Color.fromARGB(0, 0, 0, 0)
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20.0),
                                                child: Text(
                                                  'No. ${jenis.map((e) => item)} image',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                          ))
                      .toList()),
                      ),
                      
                      Container(
                        margin:const EdgeInsets.fromLTRB(17, 0, 17, 0) ,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          ),
                          child: Image.asset('images/ph3.jpg',),
                        ) 
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(17, 0, 17, 10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 2)
                                  )
                                ],
                          color: primaryClr,
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                        ),
                        child: const GFAccordion(
                          title: "Kesehatan Kandang Ternak Babi", textStyle: TextStyle(
                            color: Colors.white
                          ),
                          collapsedIcon: Text("Detail", style: TextStyle(color: Colors.white),),
                          expandedIcon:Text("Tutup", style: TextStyle(color: Colors.white),),
                          collapsedTitleBackgroundColor: primaryClr,
                          expandedTitleBackgroundColor: primaryClr,
                          content: 
                          "1. Pemelihara ternak babi, perlu melakukan desinfeksi kandang dan peralata.\n"
                          "2. Kandang-kandang dibersihkan dan didesinfeksi secara berkala teratur ( 2 x dalam seminggu).\n"
                          "3. Ternak babi dimandikan 1-2 kali seharitergantung suhu udara.\n",
                        
                          contentBackgroundColor: primaryClr, 
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color:  context.theme.dialogBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        margin:const EdgeInsets.fromLTRB(17, 0, 17, 0) ,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          ),
                          child: Image.asset('images/pig02.jpg',),
                        ) 
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(17, 0, 17, 10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 2)
                                  )
                                ],
                          color: primaryClr,
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                        ),
                        child: const GFAccordion(
                          title: "Pakan Ternak Babi", textStyle: TextStyle(
                            color: Colors.white
                          ),
                          collapsedIcon: Text("Detail", style: TextStyle(color: Colors.white),),
                          expandedIcon:Text("Tutup", style: TextStyle(color: Colors.white),),
                          collapsedTitleBackgroundColor: primaryClr,
                          expandedTitleBackgroundColor: primaryClr,
                          content: "Pemberian pakan ternak dibagi kedalam beberapa fase ternak babi : \n\n"
                          "1. Pakan Ternak Pra Starter \n\n"
                          "« Spesifikasi dari ransum prestarter ini tampak pada kandungan protein kasarnya yang tergolong tinggi, "
                          "yaitu berkisar pada 21-23%, dan serat kasar maksimal 4,0%.\n "
                          "« Pemberian ransum prestorter dapat dilakukan sejak umur 2 minggu hingga penyapihan. Hal ini dilakukan seiring dengan penurunan volume produksi air susu induk yang umumnya terjadi pada saat memasuki"
                          "minggu ke-3 pascapartus.\n"
                          "« Pemberian ransum ini harus pada tempat terpisah dari induknya untuk mencegah induk mengonsumsinya.\n"
                          "« Pemberiannya diusahakan dalam bentuk kering agar ransum yang tersisa pada tempat makan tidak cepat rusak seperti basi dan berjamur.\n"
                          "« Pola pemberiannya dilakukan sedikit demi sedikit, tetapi lebih sering.\n"
                          "« Pemberian ransum ini, dapat dilakukan sampai umur waktu anakan sapih\n"
                          "« Pakan yang diberikan sekitar 0.2-0.5 KG/Hari \n\n"
                          "2. Pakan Ternak Starter \n\n"
                          "« Ransum starter adalah ransum yang diformulasikan untuk diberikan kepada anak babi semenjak disapih (umur mulai dari 30 hari atau umur 35 hari) dengan kisaran bobot badan 10-20 kg.\n"
                          "« Spesifikasi kualitas dari ransum ini terutama proteinnya berkisar antara 19-21% dan serat kasar maksimal 4% .\n "
                          "« Sistem pemberian sama dengan pemberian ransum prestarter, dapat dilakukan dengan cara sedikit demi sedikit tetapi dengan frekuensi yang lebih sering, misalnya 3 kali sehari, yaitu pada pagi, siang, dan sore hari, terutama selama 1-2 minggu. Hal ini dilakukan untuk mencegah makanan tersisa. Selain itu juga agar peternak lebih sering memperhatikan perkembangan anak babi sehingga lebih cepat teratasi jika terjadi sesuatu.\n"
                          "« Pakan yang diberikan sekitar 1.0-1.25 KG/Hari \n"
                          "« Bentuk fisik ransum yang diberikan sebaiknya selalu dalam bentuk kering.\n\n"
                          "3. Pakan Ternak Grower \n\n"
                          "« Sesuai dengan namanya, ransum grower adalah ransum yang diformulasikan untuk diberikan pada babi fase grower, yaitu babi yang berumur +3-5 bulan, dengan kisaran bobot badan 21-60 kg.\n"
                          "« Spesifikasi kualitas dari ransum grower adalah kandungan proteinnya yang berkisar 17-18% Teknik pemberiannya baik dalam bentuk butiran pellet maupundalam bentuk tepung (mash).\n"
                          "« Pakan yang diberikan sekitar  1.25-2.25 KG dengan berat babi 21-60 KG \n\n"
                          "3. Pakan Ternak Finisher \n\n"
                          "« Finisher adalah fase siap jual maka ransumnya diformulasikan dengan tujuan untuk meningkatkan kepadatan otot ternak babi. Pembeda yang paling nyata antara ransum finisher dengan ransum sebelumnya adalah pada nilai kandungan protein kasarnya yang lebih rendah, sedangkan kandungan serat kasarnya lebih tinggi.\n"
                          "« Finisher babi dengan usia 5 sampai 7 bulan dengan kisaran berat badan 60-100 kg\n"
                          "« Pakan yang diberikan sekitar 2.5-2.75 kg/Hari \n"
                          , 
                          contentBackgroundColor: primaryClr, 
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Container(
                  color: context.theme.dialogBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        margin:const EdgeInsets.fromLTRB(17, 0, 17, 0) ,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          ),
                          child: Image.asset('images/ph5.jpg',),
                        ) 
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(17, 0, 17, 10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 2)
                                  )
                                ],
                          color: primaryClr,
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                        ),
                        child: const GFAccordion(
                          title: "Pemilihan Bibit Pejantan dan Indukan", textStyle: TextStyle(
                            color: Colors.white
                          ),
                          collapsedIcon: Text("Detail", style: TextStyle(color: Colors.white),),
                          expandedIcon:Text("Tutup", style: TextStyle(color: Colors.white),),
                          collapsedTitleBackgroundColor: primaryClr,
                          expandedTitleBackgroundColor: primaryClr,
                          content:
                           "1. Pemilihan Indukan Yang Baik\n\n"
                           "« Jumlah puting genap yakni 12-14 buah.\n"
                           "« Letak puting tepat berpasang pasangan.\n"
                           "« Antara birahi pertama dan birahi selanjutnya tepat waktu atau mendekati.\n"
                           "« Kaki kokoh dan kuat, terutama kaki belakang.\n"
                           "« Pinggul berotot lebih baik.\n\n"
                           "2. Pemilihan Pejantan Yang Baik\n\n"
                           "« Bentuk kantong testis simetris dan berukuran sama.\n"
                           "« Pengeluaran air kencing terputus putus.\n"
                           "« Kaki kokoh dan kuat.\n"
                           "« Bagian bawah perut rata.\n"
                          , 
                          contentBackgroundColor: primaryClr, 
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: context.theme.dialogBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        margin:const EdgeInsets.fromLTRB(17, 0, 17, 0) ,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          ),
                          child: Image.asset('images/ph6.jpg',),
                        ) 
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(17, 0, 17, 10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 2)
                                  )
                                ],
                          color: primaryClr,
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                        ),
                        child: const GFAccordion(
                          title: "Waktu Kawin Babi", textStyle: TextStyle(
                            color: Colors.white
                          ),
                          collapsedIcon: Text("Detail", style: TextStyle(color: Colors.white),),
                          expandedIcon:Text("Tutup", style: TextStyle(color: Colors.white),),
                          collapsedTitleBackgroundColor: primaryClr,
                          expandedTitleBackgroundColor: primaryClr,
                          content:
                           "Dewasa kelamin adalah status perkembangan biologis berkaitan dengan reproduksi ternak jantan dan betina yang menunjukkan organ reproduksinya sudah berfungsi. Dewasa kelamin pada ternak babi biasanya dicapai pada umur 6-8 bulan. Pada ternak jantan gejala dewasa kelamin ini hanya dideteksi dengan perilakunya yang sering menaiki temannya. Sementara pada ternak betina ditandai dengan gejala-gejala berahi sebagai berikut:\n\n"
                           "« Nampak gelisah, kadang-kadang diikuti dengan berteriak-teriak dan penurunan nafsu makan.\n"
                           "« Kemaluan (vagina) nampak membengkak dan kemerah-merahan, jika diraba terasa hangat.\n"
                           "« Selalu berusaha menaiki kawannya.\n"
                           "« Keluar cairan bening/transparan dari kemaluannya.\n"
                           "« Jika ditekan pada bagian punggung dia akan diam.\n\n"
                           "Lama babi mengalami prose birahi antara 1-5 hari lalu akan muncul kembali melalui siklus selanjutnya setelah 18-23 hari berikutnya.\n\n"
                           "« Bentuk kantong testis simetris dan berukuran sama.\n"
                           "« Pengeluaran air kencing terputus putus.\n"
                           "« Kaki kokoh dan kuat.\n"
                           "« Bagian bawah perut rata.\n\n"
                           
                          , 
                          contentBackgroundColor: primaryClr, 
                        ),
                      ),
                    ],
                  ),
                ),
                  Container(
                  color: context.theme.dialogBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        margin:const EdgeInsets.fromLTRB(17, 0, 17, 0) ,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          ),
                          child: Image.asset("images/ph01.jpg",),
                        ) 
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(17, 0, 17, 10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 2)
                                  )
                                ],
                          color: primaryClr,
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                        ),
                        child: const GFAccordion(
                          title: "Masa Bunting Indukan Babi", textStyle: TextStyle(
                            color: Colors.white
                          ),
                          collapsedIcon: Text("Detail", style: TextStyle(color: Colors.white),),
                          expandedIcon:Text("Tutup", style: TextStyle(color: Colors.white),),
                          collapsedTitleBackgroundColor: primaryClr,
                          expandedTitleBackgroundColor: primaryClr,
                          content:
                           "Kebuntingan babi sulit dideteksi yang dimana kebuntingan dapat dicek setelah 21 hari dari kawin tidak lagi terdeteksi gejala birahi."
                           "Setelah memasuki bulan ke dua biasanya kebuntingan tersebut sudah mulai terlihat terutama pada bagian perut indukan yang sedikit membesar."
                           "Masa bunting ini berlangsung kurang lebih 112 hingga 118 hari atau rata rata 114 hari. Dalam masa kebuntingan ini kebersihan kandang serta pakan harus di perhatikan agar menjamin kesehatan anakan babi dalam kandungan."
                          , 
                          contentBackgroundColor: primaryClr, 
                        ),
                      ),
                      
                    ],
                  ),
                ),
                  Container(
                  color: context.theme.dialogBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        margin:const EdgeInsets.fromLTRB(17, 0, 17, 0) ,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                          ),
                          child: Image.asset('images/ph6.jpg',),
                        ) 
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(17, 0, 17, 10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 2)
                                  )
                                ],
                          color: primaryClr,
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                        ),
                        child: const GFAccordion(
                          title: "Penanganan Kelahiran", textStyle: TextStyle(
                            color: Colors.white
                          ),
                          collapsedIcon: Text("Detail", style: TextStyle(color: Colors.white),),
                          expandedIcon:Text("Tutup", style: TextStyle(color: Colors.white),),
                          collapsedTitleBackgroundColor: primaryClr,
                          expandedTitleBackgroundColor: primaryClr,
                          content:
                           "Terdapat beberapa hal penting yang dilakukan setelah anakan babi keluar:\n\n"
                           "« Membersihkan lendir pembungkus anak babi terutama pada bagian gidung dengan menekan sedikit sampai anakan babi lancar untuk bernafas, biasanya akan ditandai dengan suara seperti bersin pada anakan babi.\n"
                           "« Memotong tali pusar dilakukan setelah anakan babi bersih dari lendir. hal ini dilakukan agar pusar cepat kering dan mencegah tali pusar diinjak oleh anakan lain.\n"
                           "« Beberapa hal yang disiapkan untuk melakukan pemotongan tali pusar :\n"
                           "  a. Menyiapkan gunting atau pisau tajam serta obat obatan seperti alkohol dan betadine.\n"
                           "  b. Bersikan gunting dengan alkohol\n"
                           "  c. Ikat tali pusat pada sekitar 2/3 panjang tali pusar dari pangkalnya lalu lanjut dipotong.\n"
                           "  d. Oleskan betadin pada luka potongan.\n"
                           "« Membersihkan belakang vagina indukan dari bekas darah dan lendir.\n"
                          , 
                          contentBackgroundColor: primaryClr, 
                        ),
                      ),
                      
                    ],
                  ),
                ),
                
              ],
              
            ),
          ),
        ),
      );
    
  }
}