import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_piggy_app/controllers/task_controller.dart';
import 'package:my_piggy_app/db/db_helper.dart';
import 'package:my_piggy_app/models/task.dart';
import 'package:my_piggy_app/ui/theme.dart';
import 'package:my_piggy_app/ui/widget/button.dart';
import 'package:my_piggy_app/ui/widget/input_field.dart';

class EditJadwal extends StatefulWidget {
  final Task? taskModel;
  const EditJadwal({super.key, this.taskModel});

  @override
  State<EditJadwal> createState() => _EditJadwalState();
}

class _EditJadwalState extends State<EditJadwal> {
  //deklarasi variabel
  //datetime di panggil dengan _selectDate
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now(); // hari sekarang
  String _endTime = "09.30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedRepeat = "Kosong";
  List<String> repeatList = [
    "Kosong",
    "Harian",
    "Mingguan",
  ];
  int _selectedColor = 0;
  @override
  void initState() {
    _titleController.text = widget.taskModel!.title ?? '';
    _noteController.text = widget.taskModel!.note ?? '';
    _selectedDate = DateFormat.yMd().parse((widget.taskModel!.date ?? ''));
    _startTime = widget.taskModel!.startTime ?? '';
    _endTime = widget.taskModel!.endTime ?? '';
    _selectedRepeat = widget.taskModel!.repeat ?? '';
    _selectedColor = widget.taskModel!.color!.toInt();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Penjadwalan Ternak',
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
                title: "Judul",
                hint: "Masukan judul anda",
                controller: _titleController,
              ),
              MyInputField(
                title: "Catatan",
                hint: "Masukan catatan anda",
                controller: _noteController,
              ),
              MyInputField(
                title: "Tanggal",
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
                      repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(color: Colors.grey)),
                    );
                  }).toList(),
                ),
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
                  MyBotton(
                      label: "Update",
                      onTap: () async {
                        await _validatetask();
                      })
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 3)
            ],
          ))),
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

  _validatetask() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //add to database
      await DBHelper.updateTask(widget.taskModel!.id!, {
        "note": _noteController.text,
        'title': _titleController.text,
        'date': DateFormat.yMd().format(_selectedDate),
        'startTime': _startTime,
        'endTime': _endTime,
        'repeat': _selectedRepeat,
        'color': _selectedColor,
        'isCompleted': 0,
        'tanggalLahir': DateFormat.yMd()
            .format(_selectedDate.add(const Duration(days: 114))),
        'tanggalKebiri': DateFormat.yMd()
            .format(_selectedDate.add(const Duration(days: 129))),
        'tanggalSapih': DateFormat.yMd()
            .format(_selectedDate.add(const Duration(days: 152))),
      });
      setState(() {
        _taskController.getTask();
      });
      _taskController.getTask();
      Get.back();
      Get.snackbar(
        "Sukses",
        "Update Jadwal Berhasil",
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

}
