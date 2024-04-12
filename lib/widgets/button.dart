import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:manajemen_tugas/pages/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: warna1),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
