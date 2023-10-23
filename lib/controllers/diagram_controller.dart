import 'package:get/get.dart';
import 'package:my_piggy_app/db/db_helper.dart';
import 'package:my_piggy_app/models/pakan.dart';
import 'package:my_piggy_app/models/total_data_pakan.dart';

import 'pakan_controller.dart';

class DiagramController extends GetxController {
  List<TotalDataPakan> totalDataPakan = [];
  List<Pakan> listPakans = [];
  final pakanControler = Get.put(PakanController());

  @override
  void onReady() async {
    super.onReady();
    addPakan(listPakan: pakanControler.pakanList);
    getTotalFromDb();
  }

  addPakan({required List<Pakan> listPakan}) {
    listPakans = listPakan;
    update();
  }

  getTotalFromDb() async {
    var dataFromDb = (await DBHelper.sumGroup());
    totalDataPakan = dataFromDb.map((e) => TotalDataPakan.fromJson(e)).toList();

    update();
  }
}
