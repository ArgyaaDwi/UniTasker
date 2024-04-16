import 'package:flutter/material.dart';
import 'package:manajemen_tugas/pages/home_page.dart';
import 'package:manajemen_tugas/repositories/repository.dart';
import 'package:manajemen_tugas/models/tugas.dart';

// class DetailTugas extends StatefulWidget {
//   final Map<String, dynamic>? task;

//   const DetailTugas({Key? key, required this.task}) : super(key: key);

//   @override
//   _DetailTugasState createState() => _DetailTugasState();
// }

// class _DetailTugasState extends State<DetailTugas> {
//   Map<String, dynamic>? tugas;
//   late Repository _repository;

//   @override
//   void initState() {
//     super.initState();
//     _repository = Repository();
//     loadData();
//   }

//   Future<void> loadData() async {
//     try {
//       var result = await _repository.readDataTugasById('tugas', widget.task!['id']);
//       setState(() {
//         if (result != null && result.isNotEmpty) {
//           tugas = result[0]; // Menggunakan kunci 0 untuk mengambil elemen pertama dari Map
//         } else {
//           // Handle jika tidak ada data yang ditemukan
//           tugas = null;
//         }
//       });
//     } catch (e) {
//       print('Terjadi kesalahan saat memuat data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBar(
//         title: const Text(
//           "Detail Tugas",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Center(
//         child: tugas != null ? _buildDetail() : CircularProgressIndicator(),
//       ),
//     );
//   }

//   Widget _buildDetail() {
//     return Container(
//       height: 650,
//       width: 350,
//       decoration: BoxDecoration(
//         color: Colors.blue[100],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "${tugas?['namaTugas'] ?? 'Nama Tugas Tidak Tersedia'}",
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 10),
//           SizedBox(height: 20),
//           Text(
//             "Mata Kuliah: ${tugas?['namaMatkul'] ?? 'Nama Mata Kuliah Tidak Tersedia'}",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             "Deskripsi",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             "${tugas?['deskripsi'] ?? 'Deskripsi Tidak Tersedia'}",
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(height: 20),
//           Row(
//             children: [
//               Icon(Icons.calendar_today),
//               SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${tugas?['tanggalPengumpulan'] ?? 'Tanggal Pengumpulan Tidak Tersedia'}",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             children: [
//               Icon(Icons.access_time),
//               SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${tugas?['deadline'] ?? 'Deadline Tidak Tersedia'}",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Text(
//             "Created At :",
//             style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//           ),
//           SizedBox(height: 20),
//           Text(
//             "Updated At : ",
//             style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//           ),
//         ],
//       ),
//     );
//   }

//   AppBar _appBar({required Widget title}) {
//     return AppBar(
//       title: title,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios),
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
//         },
//       ),
//     );
//   }
// }
class DetailTugas extends StatefulWidget {
  final Tugas? task;

  const DetailTugas({super.key, required this.task});

  @override
  _DetailTugasState createState() => _DetailTugasState();
}

class _DetailTugasState extends State<DetailTugas> {
  late Tugas? _tugas;

  @override
  void initState() {
    super.initState();
    _tugas = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(
        title: const Text(
          "Detail Tugas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: _buildDetail(),
      ),
    );
  }

  Widget _buildDetail() {
    return Center(
      child: Container(
        width: 350, // Lebar maksimal yang diinginkan
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width:
                  double.infinity, // Menyesuaikan dengan lebar Container utama
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20, top: 20),
              decoration: BoxDecoration(
                color: _tugas?.isDone == 0
                    ? Color.fromARGB(255, 151, 208, 255)
                    : Color.fromARGB(255, 173, 243, 181),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _tugas?.isDone == 0
                        ? 'Status: Belum Selesai'
                        : 'Status: Selesai',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width:
                  double.infinity, // Menyesuaikan dengan lebar Container utama
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${_tugas?.namaTugas}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Mata Kuliah: ${_tugas?.matkulNama}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${_tugas?.deskripsi}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_tugas?.tanggalPengumpulan}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_tugas?.deadline}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Created At: ${_tugas?.createdAt}",
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Updated At: ${_tugas?.updatedAt}",
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar({required Widget title}) {
    return AppBar(
      title: title,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          // Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}
