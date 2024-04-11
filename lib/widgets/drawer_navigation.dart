import 'package:flutter/material.dart';
import 'package:manajemen_tugas/pages/home_page.dart';
import 'package:manajemen_tugas/pages/matkul.dart';
import 'package:manajemen_tugas/pages/theme.dart';
import 'package:get/get.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/user.jpg"),
              ),
              accountName: Text("Argya Dwi Ferdinand Putra"),
              accountEmail: Text("argyawoles@gmail.com"),
              decoration: BoxDecoration(color: warna1),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list_outlined),
              title: Text('Mata Kuliah'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MatkulPage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
