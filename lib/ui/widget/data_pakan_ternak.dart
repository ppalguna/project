import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_piggy_app/controllers/pakan_controller.dart';
import 'package:my_piggy_app/db/db_helper.dart';
import 'package:my_piggy_app/models/pakan.dart';
import 'package:my_piggy_app/ui/theme.dart';
import 'package:my_piggy_app/ui/widget/history_ternak.dart';

import '../../controllers/pig_controller.dart';
import '../../models/pig.dart';
import 'button.dart';
import 'input_field_pig_data.dart';

class pigUpdate extends StatefulWidget {
  const pigUpdate({super.key});

  @override
  State<pigUpdate> createState() => _pigUpdateState();
}

class _pigUpdateState extends State<pigUpdate> {
  final PigController _pigController = Get.put(PigController());
  final PakanController _pakanController = Get.put(PakanController());
  final TextEditingController _catatanPig = TextEditingController();
  final TextEditingController _catatanPakan = TextEditingController();
  final _hargaPakan = TextEditingController();
  final _jumlahController = TextEditingController();
  final _jumlahPakanController = TextEditingController();
  DateTime _selectedDatePakan = DateTime.now();
  late double _progress;
  Timer? _timer;
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
        return MediaQuery.of(context).size.width / 2;

      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (current) {
      case 0:
        return MediaQuery.of(context).size.width / 2;
      case 1:
        return MediaQuery.of(context).size.width / 2;

      default:
        return 0;
    }
  }
  //var _jumlah;

  @override
  void initState() {
    super.initState();
    // calculate();
    // calculateAnakan();
    // calculatePenggemukan();
    // p();
  }

  var count = 0.obs;

  var dataanakan = 0;
  int _selectedColor = 0;
  String _jenisTernak = "Anakan";
  // ignore: non_constant_identifier_names
  List<String> RepeatList = [
    "Anakan",
    "Indukan",
    "Gemukan",
    "Pejantan",
  ];
  String _tipeUpdate = "Beli";
  // ignore: non_constant_identifier_names
  List<String> RepeatList2 = [
    "Beli",
    "Jual",
    "Lahir",
    "Mati",
  ];
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pakan & Ternak',
            style: subStyle.copyWith(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: context.theme.dialogBackgroundColor,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios),
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.history_edu,
                color: Colors.grey,
              ),
              iconSize: 30,
              tooltip: 'Riwayat',
              onPressed: () {
                Get.to(() => const historyTernak());
                _pigController.getPig();
                _pakanController.getPakan();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.grey[800] : Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 15,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: primaryClr,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                )),
                            child: Container(
                              padding: const EdgeInsets.only(top: 15),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tabs.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: index == 0
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                          top: 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            current = index;
                                            _formTernak();
                                            _formPakan();
                                          });
                                        },
                                        child: Text(
                                          tabs[index],
                                          style: subtitle,
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.fastLinearToSlowEaseIn,
                          ),
                        )
                      ],
                    ),
                  ),

                  current == 0 ? _formTernak() : _formPakan(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _formTernak() {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.2,
        color: primaryClr,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            decoration: BoxDecoration(
                color: primaryClr, borderRadius: BorderRadius.circular(1)),
            child: Column(
              children: [
                MyInputField2(
                  title: "Jenis Ternak",
                  hint: "$_jenisTernak ",
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitle,
                    underline: Container(
                      color: primaryClr,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _jenisTernak = newValue!;
                      });
                    },
                    items: RepeatList.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(color: Colors.grey)),
                      );
                    }).toList(),
                  ),
                ),
                MyInputField2(
                  title: "Tipe Update",
                  hint: "$_tipeUpdate ",
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitle,
                    underline: Container(
                      color: primaryClr,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _tipeUpdate = newValue!;
                      });
                    },
                    items: RepeatList2.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(color: Colors.grey)),
                      );
                    }).toList(),
                  ),
                ),
                MyInputField2(
                  title: "Catatan (Optional)",
                  hint: "Masukan catatan anda",
                  controller: _catatanPig,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 35,
          ),
          Row(
            children: [
              Text(
                "Jumlah",
                style: subtitle,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 19,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 19,
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? primaryClr : primaryClr,
                ),
                child: SizedBox(
                    child: TextFormField(
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                  controller: _jumlahController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(4)
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            color: Colors.white,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            color: Colors.white,
                          )),
                      contentPadding: EdgeInsets.all(0),
                      hintText: "0",
                      hintStyle: TextStyle(color: Colors.white)),
                )),
              ),
              const SizedBox(
                width: 20,
              ),
              _colorPallete(),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 6,
            color: primaryClr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyBotton(
                    label: "Simpan ",
                    onTap: () {
                      _validateDate();
                    })
              ],
            ),
          )
        ]));
  }

  _formPakan() {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.2,
        color: primaryClr,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            decoration: BoxDecoration(
                color: primaryClr, borderRadius: BorderRadius.circular(1)),
            child: Column(
              children: [
                MyInputField2(
                  title: "Tanggal Pembelian",
                  hint: DateFormat.yMd().format(_selectedDatePakan),
                  widget: IconButton(
                    icon: const Icon(Icons.calendar_today_outlined,
                        color: Colors.white),
                    onPressed: () {
                      //jika user klik widget akan muncul
                      _getDateFromUser();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 35,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jumlah Pakan',
                style: subtitle,
              ),
              Container(
                height: 52,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.only(left: 14.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(

                            //readOnly: widget==null?false:true, //mengecek apakah kalau ada WIdget, jika nuul maka nilainya false dan bisa di ketikan jika not null maka akan di read saja tidak bisa di ketik
                            autofocus: false,
                            cursorColor: Get.isDarkMode
                                ? Colors.grey[100]
                                : Colors.white,
                            controller: _jumlahPakanController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(11)
                            ],
                            style: subtitle,
                            decoration: InputDecoration(
                                hintText: '/sak',
                                hintStyle: subtitle.copyWith(fontSize: 13),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            context.theme.dialogBackgroundColor,
                                        width: 0)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          context.theme.dialogBackgroundColor,
                                      width: 0),
                                )))),
                    // widget==null?Container():Container(child: widget)
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 35,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Pembelian Pakan',
                style: subtitle,
              ),
              Container(
                height: 52,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.only(left: 14.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(

                            //readOnly: widget==null?false:true, //mengecek apakah kalau ada WIdget, jika nuul maka nilainya false dan bisa di ketikan jika not null maka akan di read saja tidak bisa di ketik
                            autofocus: false,
                            cursorColor: Get.isDarkMode
                                ? Colors.grey[100]
                                : Colors.white,
                            controller: _hargaPakan,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            style: subtitle,
                            decoration: InputDecoration(
                                hintText: 'Rp. ',
                                hintStyle: subtitle.copyWith(fontSize: 13),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            context.theme.dialogBackgroundColor,
                                        width: 0)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          context.theme.dialogBackgroundColor,
                                      width: 0),
                                )))),
                    // widget==null?Container():Container(child: widget)
                  ],
                ),
              )
            ],
          ),
          MyInputField2(
            title: "Catatan (Optional)",
            hint: "Masukan catatan anda",
            controller: _catatanPakan,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 6.3,
            color: primaryClr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyBotton(
                    label: "Simpan ",
                    onTap: () {
                      _validatePakan();
                    })
              ],
            ),
          )
        ]));
  }

  _addPigToDb() async {
    String jumlah = _jumlahController.text;
    DateTime tanggal = DateTime.now();
    int value = await _pigController.addPig(
      pig: Pig(
          jenisTernak: _jenisTernak,
          tipeUpdate: _tipeUpdate,
          catatanPig: _catatanPig.text,
          jumlah: int.parse(jumlah),
          color: _selectedColor,
          tanggal: DateFormat.yMd().format(tanggal)),
    );
    print("my id is" " $value");
  }

  _addPakanToDb() async {
    String jumlahPakan = _jumlahPakanController.text;
    String pakan = _hargaPakan.text;
    String bulan = _selectedDatePakan.toString();
    int value = await _pakanController.addPakan(
      pakan: Pakan(
        tanggalPakan: DateFormat.yMd().format(_selectedDatePakan),
        jumlahPakan: int.parse(jumlahPakan),
        hargaPakan: int.parse(pakan),
        catatanPakan: _catatanPakan.text,
        bulanPakan:  bulan
      ),
    );
    print("my id is" " $value");
  }

  _validateDate() {
    if (_jenisTernak.isNotEmpty &&
        _tipeUpdate.isNotEmpty &&
        _jumlahController.text.isNotEmpty) {
      //add to database
      _addPigToDb();
      _progress = 0;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 25), (Timer timer) {
        EasyLoading.instance
          ..displayDuration = const Duration(milliseconds: 1000)
          ..loadingStyle =
              EasyLoadingStyle.custom //This was missing in earlier code
          ..backgroundColor = primaryClr
          ..progressColor = Colors.white
          ..indicatorColor = Colors.white
          ..progressColor = Colors.white
          ..maskColor = Colors.white
          ..textColor = Colors.white
          ..dismissOnTap = true;
        EasyLoading.showProgress(_progress,
            status: '${(_progress * 100).toStringAsFixed(0)}%');
        _progress += 0.03;

        if (_progress >= 1) {
          _timer?.cancel();
          _pigController.dbpenggemukan;
          EasyLoading.dismiss();
          Get.back();
          Get.snackbar(
            "Sukses",
            "Input Ternak Berhasil",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            boxShadows: [
              const BoxShadow(
                color: primaryClr,
                spreadRadius: 0,
                blurRadius: 1.5,
                offset: Offset(0, 0),
              )
            ],
            icon: const Icon(
              Icons.beenhere_outlined,
              color: primaryClr,
            ),
            colorText: primaryClr,
          );
        }
      });
      setState(() {});
    } else {
      Get.snackbar(
        "Required",
        "Lengkapi semua",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        boxShadows: [
          const BoxShadow(
            color: Colors.red,
            spreadRadius: 0,
            blurRadius: 1.5,
            offset: Offset(0, 0),
          )
        ],
        icon: const Icon(
          Icons.warning_amber_outlined,
          color: Colors.white,
        ),
        colorText: Colors.white,
      );
    }
  }

  _validatePakan() {
    if (_hargaPakan.text.isNotEmpty && _jumlahPakanController.text.isNotEmpty) {
      //add to database
      _addPakanToDb();
      DBHelper.sumGroup();
      _progress = 0;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 25), (Timer timer) {
        EasyLoading.instance
          ..displayDuration = const Duration(milliseconds: 1000)
          ..loadingStyle =
              EasyLoadingStyle.custom //This was missing in earlier code
          ..backgroundColor = primaryClr
          ..progressColor = Colors.white
          ..indicatorColor = Colors.white
          ..progressColor = Colors.white
          ..maskColor = Colors.white
          ..textColor = Colors.white
          ..dismissOnTap = true;
        EasyLoading.showProgress(_progress,
            status: '${(_progress * 100).toStringAsFixed(0)}%');
        _progress += 0.03;

        if (_progress >= 1) {
          _timer?.cancel();
          _pigController.dbpenggemukan;
          EasyLoading.dismiss();
          Get.to(()=>const historyTernak());
          Get.snackbar(
            "Sukses",
            "Input Pakan Berhasil",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            boxShadows: [
              const BoxShadow(
                color: primaryClr,
                spreadRadius: 0,
                blurRadius: 1.5,
                offset: Offset(0, 0),
              )
            ],
            icon: const Icon(
              Icons.beenhere_outlined,
              color: primaryClr,
            ),
            colorText: primaryClr,
          );
        }
      });
      setState(() {});
    } else {
      Get.snackbar(
        "Required",
        "Lengkapi semua",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        boxShadows: [
          const BoxShadow(
            color: Colors.red,
            spreadRadius: 0,
            blurRadius: 1.5,
            offset: Offset(0, 0),
          )
        ],
        icon: const Icon(
          Icons.warning_amber_outlined,
          color: Colors.white,
        ),
        colorText: Colors.white,
      );
    }
  }

  _colorPallete() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Warna",
          style: subtitle,
        ),
        //wrap garis secara horizontal warnanya
        SizedBox(width: MediaQuery.of(context).size.width / 25),
        Wrap(
            children: List<Widget>.generate(3, (int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
                print("$index");
              });
            }, //ketika di tap
            child: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 11,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? greenClr
                          : yellowClr,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons
                              .done, //dimanapun di klik dan indexnya cocok maka icon tersebut akan disana ditampilkan
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            ),
          );
        })),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2123));
    if (pickerDate != null) {
      setState(() {
        _selectedDatePakan = pickerDate;
      });
    } else {
      print("it's null or something");
    }
  }

  // int totall = 0;
  // void calculate() async {
  //   var total = (await _pigController.dbh)[0]['totalInduk'];
  //   print(total);
  //   print(total);
  //   setState(() {
  //     totall = total;
  //   });
  // }

  // int totalAnakan = 0;
  // void calculateAnakan() async {
  //   var totalA = (await _pigController.dbanakan)[0]['totalAnak'];
  //   print(totalA);
  //   setState(() {
  //     totalAnakan = totalA;
  //   });
  // }

  // int totalPengemukan = 0;
  // void calculatePenggemukan() async {
  //   int totalG = (await _pigController.dbpenggemukan)[0]['totalGemukan'];

  //   setState(() {
  //     totalPengemukan = totalG;
  //   });
  // }

  // var totalPejantan = 0;
  // void p() async {
  //   var totalP = (await _pigController.pigDB)[0]['totalPejantan'];
  //   print(totalP);
  //   setState(() {
  //     totalPejantan = totalP;
  //   });
  // }
}
