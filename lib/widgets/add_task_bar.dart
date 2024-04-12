import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_tugas/pages/theme.dart';
import 'package:manajemen_tugas/repositories/repository.dart';
import 'package:manajemen_tugas/services/matkul_service.dart';
import 'package:manajemen_tugas/widgets/input_field.dart';

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
  var _selectedValue;
  late Repository _repository;
  List<DropdownMenuItem<String>> _matkul = [];
  @override
  void initState() {
    super.initState();
    _repository = Repository();
    _loadMatkul();
    initializeDateFormatting('id_ID', null);
  }

  _loadMatkul() async {
    var _matkulService = await MatkulService();
    var matkul = await _matkulService.readMatkul();
    setState(() {
      _matkul.clear(); // Bersihkan list sebelum menambahkan item baru
      matkul.forEach((matkul) {
        _matkul.add(
          DropdownMenuItem(
            value: jsonEncode(
                {'id': matkul['id'], 'namaMatkul': matkul['namaMatkul']}),
            child: Text(matkul['namaMatkul']),
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
                height: 50,
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic>? selectedValue;
                      if (_selectedValue != null &&
                          _selectedValue is Map<String, dynamic>) {
                        selectedValue = _selectedValue as Map<String, dynamic>;
                      }

                      int? idMatkul = selectedValue?['id'];
                      String? namaTugas = _namaTugasController.text;
                      String? deskripsi = _deskripsiTugasController.text;
                      String? tanggalPengumpulan =
                          DateFormat.yMMMMEEEEd('id_ID').format(_selectedDate);
                      String? deadline = _deadline;
                      DateTime now = DateTime.now();
                      String createdAt = DateTime.now().toString();
                      String updatedAt = DateTime.now().toString();

                      // Menyiapkan data tugas yang akan dimasukkan
                      Map<String, dynamic> newTask = {
                        'id_matkul': idMatkul,
                        'namaTugas': namaTugas,
                        'deskripsi': deskripsi,
                        'tanggalPengumpulan': tanggalPengumpulan,
                        'deadline': deadline,
                        'isDone': 0, // Default isDone nya 0
                        'createdAt': createdAt,
                        'updatedAt': updatedAt,
                      };

                      try {
                        // Memasukkan data tugas ke dalam database
                        int insertedId =
                            await _repository.insertDataTugas('tugas', newTask);

                        // Jika berhasil, cetak pesan berhasil
                        print(
                            'Data tugas berhasil ditambahkan dengan ID: $insertedId');
                      } catch (e) {
                        // Jika terjadi kesalahan, cetak pesan kesalahan
                        print(
                            'Terjadi kesalahan saat menambahkan data tugas: $e');
                      }
                      _loadMatkul().then((_) {
                        Navigator.pop(context);
                      });
                      _showSuccessSnackBar(const Text('Berhasil Upload Data'));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            2), // Atur border radius di sini
                      ),
                      backgroundColor: Colors
                          .blue, // Atur warna latar belakang tombol di sini
                    ),
                    child: Text(
                      "Tambah",
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
