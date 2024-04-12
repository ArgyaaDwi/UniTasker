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
  
}