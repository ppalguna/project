import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_piggy_app/controllers/task_controller.dart';
import 'package:my_piggy_app/models/task.dart';
import 'package:my_piggy_app/ui/theme.dart';
import 'package:my_piggy_app/ui/widget/button.dart';
import 'package:my_piggy_app/ui/widget/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //deklarasi variabel
  //datetime di panggil dengan _selectDate
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now(); // hari sekarang
  String _endTime = "09.30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  late double _progress;
  Timer? _timer;
  String _selectedRepeat = "Kosong";
  List<String> RepeatList = [
    "Kosong",
    "Harian",
    "Mingguan",
  ];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penjadwalan Ternak',
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
      body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          color: context.theme.dialogBackgroundColor,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyInputField(
                title: "Judul Penjadwalan",
                hint: "Masukan judul anda",
                controller: _titleController,
              ),
              MyInputField(
                title: "Catatan",
                hint: "Masukan catatan anda",
                controller: _noteController,
              ),
              MyInputField(
                title: "Tanggal Kawin",
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
              const SizedBox(
                height: 18,
              ),
               SizedBox(
                height: MediaQuery.of(context).size.height/50,
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
              SizedBox(height: MediaQuery.of(context).size.height / 5)
            ],
          ))),
    );
  }

  //membuat fungsi(funtion)
  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2123));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
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
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //add to database
      _addTaskToDb();
      _taskController.getTask();
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
          _taskController.getTask();
          Get.back();
          Get.snackbar(
            "Sukses",
            "Input Jadwal Berhasil",
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
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
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

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
        tanggalLahir: DateFormat.yMd()
            .format(_selectedDate.add(const Duration(days: 114))),
        tanggalKebiri: DateFormat.yMd()
            .format(_selectedDate.add(const Duration(days: 129))),
        tanggalSapih: DateFormat.yMd()
            .format(_selectedDate.add(const Duration(days: 152))),
      ),
    );
    print("my id is" + " $value");
  }
}
