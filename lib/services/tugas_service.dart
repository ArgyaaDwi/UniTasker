import 'package:manajemen_tugas/models/matkul.dart';
import 'package:manajemen_tugas/models/tugas.dart';
import 'package:manajemen_tugas/repositories/repository.dart';

class TugasService{
  late Repository _repository;


  TugasService(){
    _repository = Repository();
  }
  //Create Tugas
  saveTugas(Tugas tugas)async{
    return await _repository.insertDataTugas('tugas', tugas.tugasMap());
  }
  //Baca
  Future<dynamic> readTugas()async{
    return await _repository.readDataTugas('tugas');

  }
  Future<Map<String, dynamic>?> readTugasById(itemId) async {
  var result = await _repository.readDataTugasById('tugas', itemId);
  if (result != null && result.isNotEmpty) {
    return result.first;
  } else {
    return null; // Return null if no data found
  }
}


  Future<dynamic> readTugasBerdasarkanMatkul(matkul)async{
    return await _repository.readTugasByMatkul('tugas', 'matkulNama', matkul);
  }
    Future<void> updateTugas(Tugas tugas) async {
    try {
      await _repository.updateData('tugas', tugas.tugasMap());
    } catch (e) {
      // Menangani kesalahan jika terjadi
      throw Exception('Terjadi kesalahan saat memperbarui tugas: $e');
    }
  }
}
