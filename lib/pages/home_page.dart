// import 'dart:js';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_tugas/models/matkul.dart';
import 'package:manajemen_tugas/pages/theme.dart';
import 'package:manajemen_tugas/repositories/repository.dart';
import 'package:manajemen_tugas/services/matkul_service.dart';
import 'package:manajemen_tugas/widgets/add_task_bar.dart';
import 'package:manajemen_tugas/widgets/button.dart';
import 'package:get/get.dart';
import 'package:manajemen_tugas/widgets/drawer_navigation.dart';
import 'package:manajemen_tugas/models/tugas.dart';
import 'package:manajemen_tugas/services/tugas_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tugas;
  var matkul;
  DateTime _selectedDate = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Repository _repository;
  final _tugas = Tugas();
  final _tugasService = TugasService();
  final _matkul = Matkul();
  final _matkulService = MatkulService();
  List<Map<String, dynamic>> _taskList = [];

  _loadTugas() async {
    var tasks = await _repository.readDataTugas('tugas');
    setState(() {
      _taskList = tasks;
    });
  }

  @override
  void initState() {
    super.initState();
    _repository = Repository();
    _loadTugas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(
        title: const Text(
          "UniTasker",
          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const DrawerNavigation(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: ListView.builder(
        itemCount: _taskList.length,
        itemBuilder: (context, index) {
          final task = _taskList[index];
          //  _matkulService.getMatkulById(task['id_matkul']);
          // // Anda dapat menunggu respons dari layanan dan kemudian menggunakan informasi mata kuliah yang diterima:
          // // final namaMatkul = matkul['namaMatkul'];
          return GestureDetector(
            onTap: () {
              _showBottomSheet(context, task);
            },
            child: Card(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color.fromARGB(255, 151, 208, 255),
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    text: '${task['namaMatkul']}\n',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: '${task['namaTugas']}\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '${task['tanggalPengumpulan']}\n',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(
                                Icons.access_time,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '${task['deadline']}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: warna1,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd('id_ID').format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Hari Ini",
                  style: subHeadingStyle1,
                ),
              ],
            ),
          ),
          MyButton(label: "Tambah Tugas", onTap: () => Get.to(AddTaskPage()))
        ],
      ),
    );
  }

  AppBar _appBar({required Widget title}) {
    return AppBar(
      title: title,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, Map<String, dynamic> task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 320,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildDeleteTaskButton(
                        'Tandai Selesai', Color.fromARGB(255, 87, 255, 93), () {
                      // Handle delete action for Task 1
                      print('Task 1 deleted');
                    }),
                    SizedBox(height: 10),
                    _buildDeleteTaskButton(
                        'Edit', Color.fromARGB(255, 14, 91, 153), () {
                      // Handle delete action for Task 2
                      print('Task 2 deleted');
                    }),
                    SizedBox(height: 10),
                    _buildDeleteTaskButton(
                        'Delete', const Color.fromARGB(255, 180, 28, 17),
                        () async {
                      // Handle delete action for Task 3
                      try {
                        // Ambil id tugas yang akan dihapus
                        int taskId = task['id'];

                        // Hapus data tugas dari database
                        await _repository.deleteDataTugas('tugas', taskId);

                        // Cetak pesan bahwa tugas berhasil dihapus
                        print('Task $taskId deleted');

                        // Muat ulang daftar tugas di HomePage untuk menampilkan perubahan
                        _loadTugas();
                        Navigator.pop(context);
                      } catch (e) {
                        // Tangani kesalahan jika terjadi
                        print(
                            'Terjadi kesalahan saat menghapus data tugas: $e');
                      }
                    }),
                    const SizedBox(
                      height: 50,
                    ),
                    _buildCloseButton()
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildCloseButton() {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 12),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: const Text(
            'Close',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteTaskButton(
      String buttonText, Color backgroundColor, Function() onPressed) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
