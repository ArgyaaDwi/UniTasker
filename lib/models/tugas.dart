class Tugas {
  int? id;
  String? matkulNama;
  String? namaTugas;
  String? deskripsi;
  String? tanggalPengumpulan;
  String? deadline;
  int? isDone;
  String? createdAt; 
  String? updatedAt; 

  Tugas({
    this.id,
    this.matkulNama,
    this.namaTugas,
    this.deskripsi,
    this.tanggalPengumpulan,
    this.deadline,
    this.isDone,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> tugasMap() {
    return {
      'id': id,
      'matkulNama': matkulNama,
      'namaTugas': namaTugas,
      'deskripsi': deskripsi,
      'tanggalPengumpulan': tanggalPengumpulan,
      'deadline': deadline,
      'isDone': isDone,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Tugas.fromMap(Map<String, dynamic> map) {
    return Tugas(
      id: map['id'],
      matkulNama: map['matkulNama'],
      namaTugas: map['namaTugas'],
      deskripsi: map['deskripsi'],
      tanggalPengumpulan: map['tanggalPengumpulan'],
      deadline: map['deadline'],
      isDone: map['isDone'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}

