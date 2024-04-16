import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_tugas/models/tugas.dart';
import 'package:manajemen_tugas/pages/theme.dart';
import 'package:manajemen_tugas/repositories/repository.dart';
import 'package:manajemen_tugas/services/matkul_service.dart';
import 'package:manajemen_tugas/services/tugas_service.dart';
import 'package:manajemen_tugas/widgets/input_field.dart';
import 'package:manajemen_tugas/pages/home_page.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _deadline = "23.59";
  final _namaTugasController = TextEditingController();
  final _deskripsiTugasController = TextEditingController();
  final _deadlineTugasController = TextEditingController();
  late TugasService _tugasService;

  var _selectedValue;
  late Repository _repository;
  List<DropdownMenuItem<String>> _matkul = [];
  late List<Tugas> _tugasList;

  @override
  void initState() {
    super.initState();
    _repository = Repository();
    _tugasService = TugasService();
    _loadMatkul();
    _tugasList = [];
    getAllTugas();
    initializeDateFormatting('id_ID', null);
  }

  Future<void> getAllTugas() async {
    var tugasData = await _tugasService.readTugas();
    var tugasList = <Tugas>[];
    tugasData.forEach((data) {
      var tugas = Tugas(
        id: data['id'],
        matkulNama: data['matkulNama'],
        namaTugas: data['namaTugas'],
        deskripsi: data['deskripsi'],
        tanggalPengumpulan: data['tanggalPengumpulan'],
        deadline: data['deadline'],
        isDone: data['isDone'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );
      tugasList.add(tugas);
    });
    setState(() {
      _tugasList = tugasList;
    });
  }

  _loadMatkul() async {
    var _matkulService = MatkulService();
    var matkulList = await _matkulService.readMatkul();
    matkulList.forEach((matkul) {
      setState(() {
        _matkul.add(
          DropdownMenuItem(
            value: matkul['namaMatkul'],
            child: Text(
              matkul['namaMatkul'],
            ),
          ),
        );
      });
    });
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

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
              const SizedBox(
                height: 30,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Mata Kuliah',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color.fromARGB(255, 245, 239, 239),
                ),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                hint: const Text('Pilih Mata Kuliah'),
                value: _selectedValue,
                items: _matkul,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                onTap: () {
                  print(_selectedValue);
                },
                isExpanded: true,
              ),
              MyInputField(
                title: "Nama Tugas",
                hint: "Masukkan Nama Tugas",
                controller: _namaTugasController,
              ),
              MyInputField(
                title: "Deskripsi",
                hint: "Masukkan Deskripsi Tugas",
                controller: _deskripsiTugasController,
              ),
              MyInputField(
                title: "Tanggal Pengumpulan",
                hint: DateFormat.yMMMEd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.black,
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
                  icon: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var tugasObject = Tugas();
                      tugasObject.matkulNama = _selectedValue.toString();
                      tugasObject.namaTugas = _namaTugasController.text;
                      tugasObject.deskripsi = _deskripsiTugasController.text;
                      String? tanggalPengumpulan =
                          DateFormat.yMMMMEEEEd('id_ID').format(_selectedDate);
                      String? deadline = _deadline;

                      tugasObject.tanggalPengumpulan = tanggalPengumpulan;
                      tugasObject.deadline = deadline;

                      tugasObject.isDone = 0;
                      tugasObject.createdAt = DateTime.now().toString();
                      tugasObject.updatedAt = DateTime.now().toString();
                      var _tugasService = TugasService();
                      var result = await _tugasService.saveTugas(tugasObject);
                      print(result);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      getAllTugas();
                      _showSuccessSnackBar(const Text('Berhasil Upload Data'));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: Color.fromARGB(255, 46, 127, 55),
                    ),
                    child: Text(
                      "Upload",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
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
