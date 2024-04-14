import 'package:flutter/material.dart';
import 'package:manajemen_tugas/models/tugas.dart';
import 'package:manajemen_tugas/services/tugas_service.dart';

class TugasByMatkul extends StatefulWidget {
  final String? matkul;
  const TugasByMatkul({super.key, this.matkul});

  @override
  State<TugasByMatkul> createState() => _TugasByMatkulState();
}

class _TugasByMatkulState extends State<TugasByMatkul> {
  List<Tugas> _tugasList = [];
  TugasService _tugasService = TugasService();

  @override
  void initState() {
    super.initState();
    getTugasByMatkul();
  }

  getTugasByMatkul() async {
    var tugas = await _tugasService.readTugasBerdasarkanMatkul(widget.matkul);
    tugas.forEach((tugas) {
      setState(() {
        var model = Tugas();
        model.namaTugas = tugas['namaTugas'];
        model.matkulNama = tugas['matkulNama'];
        model.deskripsi = tugas['deskripsi'];
        model.tanggalPengumpulan = tugas['tanggalPengumpulan'];
        model.deadline = tugas['deadline'];
        _tugasList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tugas Menurut Matkul"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _tugasList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: const Color.fromARGB(255, 151, 208, 255),
                      child: ListTile(
                        title: RichText(
                          text: TextSpan(
                            text: '${_tugasList[index].matkulNama}\n',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: '${_tugasList[index].namaTugas}\n',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: '"${_tugasList[index].deskripsi}"\n',
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
                                    text:
                                        '${_tugasList[index].tanggalPengumpulan}\n',
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
                                    text: '${_tugasList[index].deadline}\n',
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
                    );
                  }))
        ],
      ),
    );
  }
}
