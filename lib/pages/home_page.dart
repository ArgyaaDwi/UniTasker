import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:manajemen_tugas/pages/theme.dart';
import 'package:manajemen_tugas/widgets/add_task_bar.dart';
import 'package:manajemen_tugas/widgets/button.dart';
import 'package:get/get.dart';
import 'package:manajemen_tugas/widgets/drawer_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
    final List<Map<String, dynamic>> yourTaskList = [
      {
        'namaMatkul': 'Workshop Aplikasi Berbasis Web',
        'namaTugas': 'CRUD Laravel',
        'tanggalPengumpulan': '9/6/2024',
        'deadline': '23:59'
      },
      {
        'namaMatkul': 'Workshop Aplikasi Berbasis Web',
        'namaTugas': 'CRUD Laravel',
        'tanggalPengumpulan': '9/6/2024',
        'deadline': '23:59'
      },
    ];
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print("Matkul Ditekan");
        },
        child: ListView.builder(
          itemCount: yourTaskList.length,
          itemBuilder: (context, index) {
            final task = yourTaskList[index];
            return Card(
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
                // trailing: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //         print("Edit button pressed");
                //       },
                //       icon: const Icon(
                //         Icons.edit,
                //         color: Colors.black,
                //       ),
                //     ),
                //     // IconButton(
                //     //   onPressed: () {
                //     //     print("Delete button pressed");
                //     //   },
                //     //   icon: const Icon(
                //     //     Icons.delete,
                //     //     color: Colors.black,
                //     //   ),
                //     // ),
                //   ],
                // ),
              ),
            );
          },
        ),
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
}
