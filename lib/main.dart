import 'package:flutter/material.dart';
import 'package:manajemen_tugas/pages/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:manajemen_tugas/pages/theme.dart';

void main() {
  initializeDateFormatting('id_ID', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Manajemen Tugas',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.light,
      home: HomePage(),
    );
  }
}
