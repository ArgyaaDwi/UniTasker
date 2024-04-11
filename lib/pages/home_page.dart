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
      {'namaTugas': 'Task 1'},
      {'namaTugas': 'Task 2'},
      {'namaTugas': 'Task 3'},
      {'namaTugas': 'Task 4'},
      {'namaTugas': 'Task 5'},
    ];
    return Expanded(
      child: ListView.builder(
        itemCount: yourTaskList.length,
        itemBuilder: (context, index) {
          final task = yourTaskList[index];
          return Container(
            width: 100,
            height: 50,
            color: Colors.green,
            margin: const EdgeInsets.all(16),
            child: Text(task['namaTugas'] ?? ''),
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
}
