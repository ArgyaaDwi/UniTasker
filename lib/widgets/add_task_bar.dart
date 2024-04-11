import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_tugas/pages/theme.dart';
import 'package:manajemen_tugas/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _deadline = "23.59";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tambah Tugas",
                style: headingStyle,
              ),
              const MyInputField(title: "Tugas", hint: "Masukkan judul"),
              const MyInputField(title: "Judul", hint: "Masukkan judul"),
              MyInputField(
                title: "Tanggal Pengumpulan",
                hint: DateFormat.yMMMEd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    print("Hi There");
                    _getDateFromUser();
                  },
                ),
              ),
              MyInputField(
                title: "Deadline",
                hint: _deadline,
                widget: IconButton(
                  onPressed: () {
                    _getTimeFromUser(isDeadline: true);
                  },
                  icon: Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
      ),
      actions: const [
        // Icon(
        //   Icons.person,
        //   size: 20,
        // )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2040));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("Kosong");
    }
  }

  _getTimeFromUser({required bool isDeadline}) async {
    TimeOfDay? pickedTime = await _showTimePicker();
    if (pickedTime != null) {
      String _formatTime = pickedTime.format(context);
      if (isDeadline) {
        _deadline = _formatTime;
      }
    } else {
      print("kosong");
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(hour: 23, minute: 59),
    );
  }
}
