import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/db/db_helper.dart';

import '../models/profil.dart';

class ProfilController extends GetxController {
  get text => null;

  var profilList = <Profil>[].obs;

  final TextEditingController namaPeternakController = TextEditingController();
  final TextEditingController namaPeternakanController =
      TextEditingController();
  Uint8List? foto;

  List<Map<String, dynamic>>? profil;

  @override
  void onReady() {
    super.onReady();
    getProfil();
  }

  Future<int> addProfil({Future? showDialog, Profil? profil}) async {
    //Task model menjadi task object
    return await DBHelper.insertprofil(profil);
  }

  void getProfil() async {

    List<Map<String, dynamic>> profil = await DBHelper.query3();
    profilList.assignAll(
        profil.map((dataprofil) => Profil.fromJson(dataprofil)).toList());

    if (profilList.isNotEmpty) {
      foto=profilList.first.foto;
      namaPeternakController.text = profilList.first.namaPeternak ?? "";
      namaPeternakanController.text = profilList.first.namaPeternakan ?? "";
    }
  }

  void updateprofil(int id) async {
    await DBHelper.update(id);

    getProfil();
  }
}
