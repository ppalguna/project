import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_piggy_app/controllers/note_controller.dart';
//import 'package:my_piggy_app/controllers/task_controller.dart';
import 'package:my_piggy_app/models/note.dart';
//import 'package:my_piggy_app/models/task.dart';
import 'package:my_piggy_app/ui/theme.dart';
import 'package:my_piggy_app/ui/widget/button.dart';
import 'package:my_piggy_app/ui/widget/input_field.dart';

import 'utils.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //deklarasi variabel
  //datetime di panggil dengan _selectDate

  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.camera, 30);

    setState(() {
      _image = img;
      //  print(_image!.lengthInBytes);
    });
  }

  // File? _coppressFile;
  final NoteController _noteController = Get.put(NoteController());
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  DateTime _selectedDate = DateTime.now(); // hari sekarang
  String _endTime = "09.30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedRepeat = "Hari Ini";
  late double _progress;
  Timer? _timer;
  // ignore: non_constant_identifier_names
  List<String> RepeatList = [
    "Hari ini",
    "Harian",
    "Mingguan",
  ];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catatan',
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
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            color: context.theme.dialogBackgroundColor,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyInputField(
                  title: "Nama Catatan",
                  hint: "Masukan nama catatan anda",
                  controller: _judulController,
                ),
                MyInputField(
                  title: "Catatan",
                  hint: "Masukan catatan anda",
                  controller: _keteranganController,
                ),
                MyInputField(
                  title: "Tanggal Catatan",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: const Icon(Icons.calendar_today_outlined,
                        color: Colors.grey),
                    onPressed: () {
                      //jika user klik widget akan muncul
                      _getDateFromUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: "Waktu Mulai",
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeForUser(isStartTime: true);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MyInputField(
                        title: "Waktu Berakhir",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeForUser(isStartTime: false);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                MyInputField(
                  title: "Pengulangan",
                  hint: "$_selectedRepeat ",
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    items:
                        RepeatList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(color: Colors.grey)),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Text(
                  'Tambah Gambar',
                  style: titleStyle,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _image != null
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 3)),
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 7,
                                child: Image.memory(
                                  _image!,
                                  fit: BoxFit.cover,
                                ))
                            : Container(
                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 3)),
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 7,
                                child: Image.asset('images/addimage.png'),
                              ),
                      ],
                    ),
                    _image == null
                        ? IconButton(
                            onPressed: () async {
                              selectImage();
                            },
                            icon: const Icon(Icons.add_a_photo),
                          )
                        : IconButton(
                            onPressed: () async {
                              selectImage();
                            },
                            icon: const Icon(Icons.replay_outlined),
                          ),
                  ],
                ),
                _colorPallete(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  SizedBox(
                  width: MediaQuery.of(context).size.width/1,
                 ),
                    MyBotton(label: "Simpan", onTap: () => _validateDate())
                  ],
                ),
                
              ],
            ))),
      ),
    );
  }

  //membuat fungsi(funtion)
  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2123));
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {
      print("it's null or something");
    }
  }

  _getTimeForUser({required bool isStartTime}) async {
    var pickerTime = await _showTimePicker();
    // ignore: use_build_context_synchronously
    String formatedTime = pickerTime.format(context);
    if (pickerTime == null) {
      print("Time Canceld");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = formatedTime;
      });
    }
  }

//membuat funtion
  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          //string to int
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Warna",
          style: titleStyle,
        ),
        //wrap garis secara horizontal warnanya
        const SizedBox(
          height: 8.0,
        ),
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
                radius: 14,
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
          );
        })),
      ],
    );
  }

  _validateDate() async {
    if (_judulController.text.isNotEmpty &&
        _keteranganController.text.isNotEmpty) {
      //add to database
      await _addNoteToDb();
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
          EasyLoading.dismiss();
          _noteController.getNote();
          Get.back();
          Get.snackbar(
            "Sukses",
            "Input Catatan Berhasil",
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
    } else if (_judulController.text.isEmpty ||
        _keteranganController.text.isEmpty) {
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

  _addNoteToDb() async {
    int value = await _noteController.addNote(
      note: Note(
          judul: _judulController.text,
          keterangan: _keteranganController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0,
          image: _image),
    );
    print("my id is" " $value");
  }
}
