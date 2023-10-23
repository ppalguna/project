import 'package:get/get.dart';
import 'package:my_piggy_app/db/db_helper.dart';

import '../models/pig.dart';

class PigController extends GetxController {
  static PigController get to => Get.isRegistered<PigController>()
      ? Get.find<PigController>()
      : Get.put(
          PigController(),
        );
        
  get text => null;

  var pigList = <Pig>[].obs;

  
  var dbh = DBHelper.calculateInduk();
  var dbanakan = DBHelper.calculateAnakan();
  var dbpenggemukan = DBHelper.totalGemukan();
//var dbpejantan =DBHelper.calculatePejantan();
  var pigDB = DBHelper.p();

  @override
  void onReady() {
    super.onReady();
    getPig();
  }

  calculatePigData() {
    calculateAnakan();
    calculatePejantan();
    calculateTotalIndukan();
    calculatePenggemukan();
    calculateMasuk() ;
    calculateMati();
    calculateJual();
    calculateBeli();
  }

  Future<int> addPig({Future? showDialog, Pig? pig}) async {
    //Task model menjadi task object
    return await DBHelper.insertpig(pig);
  }

  void getPig() async {
    List<Map<String, dynamic>> pig = await DBHelper.query4();
    pigList.assignAll(pig.map((datapig) => Pig.fromJson(datapig)).toList());
    calculatePigData();
  }

  void deletepig(Pig pig) {
    DBHelper.deletepig(pig);
    getPig();
  }


  RxInt totalAnakan = 0.obs;
  void calculateAnakan() async {
    var totalA = (await DBHelper.calculateAnakan())[0]['totalAnak'];
    print(totalA);
    // setState(() {
    totalAnakan.value = totalA ?? 0;
    // });
    update();
  }

  RxInt totalPejantan = 0.obs;
  void calculatePejantan() async {
    var totalP = (await DBHelper.p())[0]['totalPejantan'];
    print(totalP);
    // setState(() {
    totalPejantan.value = totalP ?? 0;
    // });
    update();
  }
  RxInt jumMasuk = 0.obs;
  void calculateMasuk() async {
    var totalm = (await DBHelper.calculateMasuk())[0]['jumMasuk'];
    print(totalm);
    // setState(() {
    jumMasuk.value = totalm ?? 0;
    // });
    update();
  }

 RxInt jumMati = 0.obs;
  void calculateMati() async {
    var totalD = (await DBHelper.calculateKeluar())[0]['jumMati'];
    print(totalD);
    // setState(() {
    jumMati.value = totalD ?? 0;
    // });
    update();
  }
   RxInt jumJual = 0.obs;
  void calculateJual() async {
    var totalJ = (await DBHelper.calculateJual())[0]['jumJual'];
    print(totalJ);
    // setState(() {
    jumJual.value = totalJ ?? 0;
    // });
    update();
  }
     RxInt jumBeli = 0.obs;
  void calculateBeli() async {
    var totalB = (await DBHelper.calculateBeli())[0]['jumBeli'];
    print(totalB);
    // setState(() {
    jumBeli.value = totalB ?? 0;
    // });
    update();
  }
  RxInt totalIndukan = 0.obs;
  void calculateTotalIndukan() async {
    var total = (await DBHelper.calculateInduk())[0]['totalInduk'];
    print(total);
    print(total);
    // setState(() {
    totalIndukan.value = total ?? 0;

    // });
    update();
  }

  RxInt totalPengemukan = 0.obs;
  void calculatePenggemukan() async {
    var totalG = (await DBHelper.totalGemukan())[0]['totalGemukan'];

    // setState(() {
    totalPengemukan.value = totalG ?? 0;
    // });

    update();
  }

  int calculateAllTotalTernak() {
    return totalIndukan.value +
        totalPejantan.value +
        totalPengemukan.value +
        totalAnakan.value;
  }
}
