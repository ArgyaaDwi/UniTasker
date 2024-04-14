// import 'dart:js';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_tugas/models/matkul.dart';
import 'package:manajemen_tugas/pages/detail_tugas.dart';
import 'package:manajemen_tugas/pages/theme.dart';
import 'package:manajemen_tugas/repositories/repository.dart';
import 'package:manajemen_tugas/services/matkul_service.dart';
import 'package:manajemen_tugas/widgets/add_task_bar.dart';
import 'package:manajemen_tugas/widgets/button.dart';
// import 'package:get/get.dart';
import 'package:manajemen_tugas/widgets/drawer_navigation.dart';
import 'package:manajemen_tugas/models/tugas.dart';
import 'package:manajemen_tugas/services/tugas_service.dart';
import 'package:manajemen_tugas/widgets/edit_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _tanggalPengumpulan;

  var tugas;
  var matkul;
  DateTime _selectedDate = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Repository _repository;
  final _tugas = Tugas();
  late TugasService _tugasService;
  final _matkul = Matkul();
  final _matkulService = MatkulService();
  late List<Tugas> _tugasList;
  @override
  void initState() {
    super.initState();
    _tugasList = [];
    _tugasService = TugasService();
    _repository = Repository();
    getAllTugas();
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

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
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
        itemCount: _tugasList.length,
        itemBuilder: (context, index) {
          final task = _tugasList[index];
          Color itemColor = task.isDone == 0
              ? Color.fromARGB(255, 151, 208, 255)
              : Color.fromARGB(255, 173, 243, 181);

          return GestureDetector(
            onTap: () {
              _showBottomSheet(context, task, index);
            },
            child: Card(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: itemColor,
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    text: '${task.matkulNama}\n',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: '${task.namaTugas}\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      // TextSpan(
                      //   text: '${task.isDone == 0 ? "Belum" : "Selesai"}\n',
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.normal,
                      //     fontSize: 14,
                      //     height: 1.5,
                      //   ),
                      // ),

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
                            text: '${task.tanggalPengumpulan}\n',
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
                            text: '${task.deadline}',
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
          setState(() {
            _selectedDate = date;
            _tanggalPengumpulan = DateFormat.yMMMMEEEEd('id_ID').format(date);
            print('Tanggal yang dipilih: $_selectedDate');
          });
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
          Column(
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
          MyButton(
            label: "Tambah Tugas",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskPage()),
              ).then((_) => getAllTugas());
            },
          ),
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

  _showBottomSheet(BuildContext context, Tugas task, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 390,
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
                    _buildTaskButton(
                      'Detail Tugas',
                      const Color.fromARGB(255, 57, 89, 249),
                      () async {
                        try {
                          var selectedTaskId = task.id;
                          print('Selected Task ID: $selectedTaskId');
                          var result =
                              await _tugasService.readTugasById(selectedTaskId);
                          if (result != null) {
                            var tugas = Tugas(
                              id: result['id'],
                              matkulNama: result['matkulNama'],
                              namaTugas: result['namaTugas'],
                              deskripsi: result['deskripsi'],
                              tanggalPengumpulan: result['tanggalPengumpulan'],
                              deadline: result['deadline'],
                              isDone: result['isDone'],
                              createdAt: result['createdAt'],
                              updatedAt: result['updatedAt'],
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailTugas(task: tugas),
                              ),
                            );
                          } else {
                            print('Data tugas tidak ditemukan');
                          }
                        } catch (e) {
                          print('Terjadi Kesalahan $e');
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTaskButton(
                      task.isDone == 0 ? 'Tandai Selesai' : 'Belum Selesai',
                      task.isDone == 0
                          ? Color.fromARGB(255, 87, 255, 93)
                          : Colors.red,
                      () async {
                        try {
                          var selectedTask = _tugasList[index];
                          if (selectedTask.isDone == 0) {
                            // Jika belum selesai, tandai sebagai selesai
                            selectedTask.isDone = 1;
                            task.updatedAt = DateTime.now().toString();
                          } else {
                            // Jika selesai, tandai sebagai belum selesai
                            selectedTask.isDone = 0;
                            task.updatedAt = DateTime.now().toString();
                          }
                          await _tugasService.updateTugas(selectedTask);
                          Navigator.pop(context);
                          setState(() {});
                          print(
                              'Tugas "${selectedTask.namaTugas}" telah diperbarui.');
                        } catch (e) {
                          print('Terjadi kesalahan saat memperbarui tugas: $e');
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTaskButton(
                        'Edit', const Color.fromARGB(255, 51, 139, 211),
                        () async {
                      try {
                        var selectedTaskId = task.id;
                        print('Selected Task ID: $selectedTaskId');
                        var result =
                            await _tugasService.readTugasById(selectedTaskId);
                        if (result != null) {
                          var tugas = Tugas(
                            id: result['id'],
                            matkulNama: result['matkulNama'],
                            namaTugas: result['namaTugas'],
                            deskripsi: result['deskripsi'],
                            tanggalPengumpulan: result['tanggalPengumpulan'],
                            deadline: result['deadline'],
                            isDone: result['isDone'],
                            createdAt: result['createdAt'],
                            updatedAt: result['updatedAt'],
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTask(task: tugas),
                            ),
                          ).then((_) {
                            // Pembaruan data hanya dilakukan setelah selesai mengedit tugas
                            getAllTugas();
                          });
                        } else {
                          print('Data tugas tidak ditemukan');
                        }
                      } catch (e) {
                        print('Terjadi Kesalahan $e');
                      }
                    }),
                    const SizedBox(height: 10),
                    _buildTaskButton(
                        'Delete', const Color.fromARGB(255, 180, 28, 17),
                        () async {
                      try {
                        var taskId = task.id; // Akses id dari map
                        await _repository.deleteDataTugas('tugas', taskId);
                        print('Task $taskId deleted');
                        getAllTugas();
                        Navigator.pop(context);
                        _showSuccessSnackBar(
                            const Text('Berhasil Menghapus Data'));
                      } catch (e) {
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

  Widget _buildTaskButton(
    String buttonText,
    Color backgroundColor,
    Function() onPressed,
  ) {
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
