import 'package:manajemen_tugas/models/matkul.dart';

class Tugas{
  int? id;
  Matkul? namaMatkul;
  String? namaTugas;
  String? deskripsi;
  String? tanggalPengumpulan;
  String? deadLine;
  bool? isDone;

  Tugas({
    this.id,
    this.namaMatkul,
    this.namaTugas,
    this.deskripsi,
    this.tanggalPengumpulan,
    this.deadLine,
    this.isDone,

  });

  Map<String, dynamic> tugasMap(){
    var mappings = <String, dynamic>{};
    mappings['id'] = id;
    mappings['namaMatkul'] = namaMatkul;
    mappings['namaTugas'] = namaTugas;
    mappings['deskripsi'] = deskripsi;
    mappings['tanggalPengumpulan'] = tanggalPengumpulan;
    mappings['deadLine'] = deadLine;
    mappings['isDone'] = isDone;

    return mappings;
  }
}

