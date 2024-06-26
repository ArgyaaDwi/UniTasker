import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manajemen_tugas/pages/theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });

  @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           title,
  //           style: titleStyle,
  //         ),
  //         Container(
  //           height: 52,
  //           margin: const EdgeInsets.only(top: 8.0),
  //           padding: const EdgeInsets.only(left: 14),
  //           decoration: BoxDecoration(
  //               color: const Color.fromARGB(255, 255, 255, 255),
  //               border: Border.all(color: Colors.grey, width: 1.0),
  //               borderRadius: BorderRadius.circular(12)),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: TextFormField(
  //                   readOnly: widget == null ? false : true,
  //                   autofocus: false,
  //                   controller: controller,
  //                   style: subTitleStyle,
  //                   decoration: InputDecoration(
  //                     hintText: hint,
  //                     hintStyle: subTitleStyle,
  //                     focusedBorder: UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                           color: context.theme.colorScheme.background,
  //                           width: 0),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 1.0),
            padding: const EdgeInsets.only(left: 12, bottom: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 239, 239),
              border: Border.all(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Menghilangkan garis bawah
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: InputBorder
                          .none, // Juga menghilangkan garis bawah saat input field dalam fokus
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
