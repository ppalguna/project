
import 'package:get/get.dart';
import 'package:my_piggy_app/db/db_helper.dart';
import 'package:my_piggy_app/models/pakan.dart';


class PakanController extends GetxController{
  get text => null;



  var pakanList = <Pakan>[].obs;
  var pakanListku = <Pakan>[].obs;
@override
  void onReady() {
    super.onReady();
    getPakan();
    getPakansum();
  }
 Future< int > addPakan({Future? showDialog, Pakan? pakan}) async{ 
  //Task model menjadi task object 
  return await DBHelper.insertPakan(pakan);
 }
 void getPakan() async {
  List<Map<String, dynamic>> pakan =await DBHelper.query5();
  pakanList.assignAll(pakan.map((datapakan) => Pakan.fromJson(datapakan)).toList());

 }
 void getPakanSOrt() async {
  List<Map<String, dynamic>> pakan =await DBHelper.query6();
  pakanList.assignAll(pakan.map((datapakanku) => Pakan.fromJson(datapakanku)).toList());
 }
 void getPakansum() async {
  List<Map<String, dynamic>> pakan =await DBHelper.sumGroup();
  pakanListku.assignAll(pakan.map((datapakanmu) => Pakan.fromJson(datapakanmu)).toList());
 }
List <Pakan> dataPakanKu = <Pakan>[];
void datapakan()async{
  dataPakanKu= await DBHelper.getpakan2() ;
update();
}
  // RxInt pakanBulanan = 0.obs;
  // RxInt bulanPakanku = 0.obs;
  // void calculatePakanBulanan() async {
  //   var totalPakanB = (await DBHelper.sumGroup())[0]['jumlahPakanBulan'];
  //  // var totalBulan = (await DBHelper.sumGroup())[0]['pakanBulanan'];
  //   print(totalPakanB);
  //   // setState(() {
  //   pakanBulanan.value = totalPakanB ?? 0;
  //   //bulanPakanku.value = totalBulan ?? '0';
  //   // });
  //   update();
  // }

//   void deletepakan(Pakan pakan){
//    DBHelper.deletepakan(pakan);
//   getPakan();
//  }

 
}