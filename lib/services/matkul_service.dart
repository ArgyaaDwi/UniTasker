import 'package:manajemen_tugas/models/matkul.dart';
import 'package:manajemen_tugas/repositories/repository.dart';

class MatkulService {
  late Repository _repository;

  MatkulService() {
    _repository = Repository();
  }
  // Create Matkul
  saveMatkul(Matkul matkul) async {
    return await _repository.insertDataMatkul('matkul', matkul.matkulMap());
  }

  //Baca Data Tabel Matkul
  Future<dynamic> readMatkul() async {
    return await _repository.readDataMatkul('matkul');
  }

  //Edit
  Future<dynamic> readMatkulById(matkulId) async {
    return await _repository.readDataById('matkul', matkulId);
  }

  Future<dynamic> updateMatkul(Matkul matkul) async {
    return await _repository.updateData('matkul', matkul.matkulMap());
  }

  Future<dynamic> deleteMatkul(matkulId) async {
    return await _repository.deleteData('matkul', matkulId);
  }
}
