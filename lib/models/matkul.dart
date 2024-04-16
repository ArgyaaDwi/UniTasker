class Matkul {
  int? id;
  String? namaMatkul;
  String? namaDosen;
  String? hari;
  String? jamMulai;
  String? jamBerakhir;
  String? ruangan;
  // String? createdAt;
  // String? updatedAt;

  Matkul(
      {this.id,
      this.namaMatkul,
      this.namaDosen,
      this.hari,
      this.jamMulai,
      this.jamBerakhir,
      this.ruangan,
    
      });

  Map<String, dynamic> matkulMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['namaMatkul'] = namaMatkul;
    mapping['namaDosen'] = namaDosen;
    mapping['hari'] = hari;
    mapping['jamMulai'] = jamMulai;
    mapping['jamBerakhir'] = jamBerakhir;
    mapping['ruangan'] = ruangan;
 

    return mapping;
  }
}
