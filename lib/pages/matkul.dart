import 'package:flutter/material.dart';
import 'package:manajemen_tugas/pages/home_page.dart';
import 'package:manajemen_tugas/services/matkul_service.dart';
import 'package:manajemen_tugas/models/matkul.dart';

class MatkulPage extends StatefulWidget {
  const MatkulPage({super.key});

  @override
  State<MatkulPage> createState() => _MatkulPageState();
}

class _MatkulPageState extends State<MatkulPage> {
  var matkul;
  // kontroller tambah
  final _namaMatkulController = TextEditingController();
  final _namaDosenController = TextEditingController();
  final _hariMatkulController = TextEditingController();
  final _jamMulaiMatkulController = TextEditingController();
  final _jamBerakhirMatkulController = TextEditingController();
  final _ruanganMatkulController = TextEditingController();
  // kontroller edit
  final _editnamaMatkulController = TextEditingController();
  final _editnamaDosenController = TextEditingController();
  final _edithariMatkulController = TextEditingController();
  final _editjamMulaiMatkulController = TextEditingController();
  final _editjamBerakhirMatkulController = TextEditingController();
  final _editruanganMatkulController = TextEditingController();
  //memanggil model Matkul
  final _matkul = Matkul();
  final _matkulService = MatkulService();
  String jamMulai = '';
  String jamBerakhir = '';

  List<Matkul> _matkulList = [];

  @override
  void initState() {
    super.initState();
    getAllMatkul();
  }

  // final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  // membaca data dari matkul yang ada
  Future<void> getAllMatkul() async {
    _matkulList = [];
    var matkulData = await _matkulService.readMatkul();
    matkulData.forEach((matkul) {
      var matkulModel = Matkul();
      matkulModel.id = matkul['id'];
      matkulModel.namaMatkul = matkul['namaMatkul'];
      matkulModel.namaDosen = matkul['namaDosen'];
      matkulModel.hari = matkul['hari'];
      matkulModel.jamMulai = matkul['jamMulai'];
      matkulModel.jamBerakhir = matkul['jamBerakhir'];
      matkulModel.ruangan = matkul['ruangan'];

      _matkulList.add(matkulModel);
    });

    // panggil setState setelah perubahan selesai dilakukan
    setState(() {});
  }

  Future<void> _editMatkul(BuildContext context, matkulId) async {
    matkul = await _matkulService.readMatkulById(matkulId);
    print('Data matkul: $matkul');

    setState(() {
      _editnamaMatkulController.text =
          matkul[0]['namaMatkul'] ?? 'Tidak Ada Matkul';
      _editnamaDosenController.text =
          matkul[0]['namaDosen'] ?? 'Tidak Ada Nama Dosen';
      _edithariMatkulController.text = matkul[0]['hari'] ?? 'Tidak Ada Hari';
      _editjamMulaiMatkulController.text =
          matkul[0]['jamMulai'] ?? 'Tidak Ada Jam Mulai';
      _editjamBerakhirMatkulController.text =
          matkul[0]['jamBerakhir'] ?? 'Tidak Ada Jam Berakhir';
      _editruanganMatkulController.text =
          matkul[0]['ruangan'] ?? 'Tidak Ada Ruangan';
    });
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _globalKey,
      appBar: _appBar(
        title: const Text(
          "Mata Kuliah",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Cari Mata Kuliah...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.black,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _matkulList.length,
                itemBuilder: (context, index) {
                  var matkul = _matkulList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: const Color.fromARGB(255, 151, 208, 255),
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: '${matkul.namaMatkul}\n', // nama matkul
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: '${matkul.namaDosen}\n', // nama dosen
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${matkul.hari} (${matkul.jamMulai}-${matkul.jamBerakhir})\n', //  hari beserta jam
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            TextSpan(
                              text: matkul.ruangan, // ruangan
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // subtitle: const Padding(
                      //   padding:  EdgeInsets.only(top: 8.0),
                      //   child:  Text(
                      //     "Edited: 09/04/2024",
                      //     style:  TextStyle(
                      //       fontSize: 10,
                      //       fontStyle: FontStyle.italic,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _editFormDialog(context);
                              _editMatkul(context, _matkulList[index].id);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteFormDialog(context, _matkulList[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        elevation: 10,
        backgroundColor: const Color.fromRGBO(17, 35, 90, 1.0),
        child: const Icon(
          Icons.add,
          size: 38,
          color: Colors.white,
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomePage()));
        },
      ),
    );
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                _matkul.namaMatkul = _namaMatkulController.text;
                _matkul.namaDosen = _namaDosenController.text;
                _matkul.hari = _hariMatkulController.text;
                _matkul.jamMulai = _jamMulaiMatkulController.text;
                _matkul.jamBerakhir = _jamBerakhirMatkulController.text;
                _matkul.ruangan = _ruanganMatkulController.text;
                var result = await _matkulService.saveMatkul(_matkul);
                print(result);

                getAllMatkul().then((_) {
                  Navigator.pop(context);
                });
                _showSuccessSnackBar(const Text('Berhasil Upload Data'));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text(
            'Form Mata Kuliah',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _namaMatkulController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Mata Kuliah Baru',
                    labelText: 'Mata Kuliah',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _namaDosenController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Dosen Pengampu Kuliah Baru',
                    labelText: 'Dosen Pengampu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _hariMatkulController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Hari',
                    labelText: 'Hari',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _selectTime(context, 'start');
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _jamMulaiMatkulController,
                            decoration: InputDecoration(
                              hintText: 'Jam Mulai',
                              labelText: 'Start',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.access_time),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _selectTime(context, 'end');
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _jamBerakhirMatkulController,
                            decoration: InputDecoration(
                              hintText: 'Jam Berakhir',
                              labelText: 'End',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.access_time),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _ruanganMatkulController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Ruangan',
                    labelText: 'Ruangan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                _matkul.id = matkul[0]['id'];
                _matkul.namaMatkul = _editnamaMatkulController.text;
                _matkul.namaDosen = _editnamaDosenController.text;
                _matkul.hari = _edithariMatkulController.text;
                _matkul.jamMulai = _editjamMulaiMatkulController.text;
                _matkul.jamBerakhir = _editjamBerakhirMatkulController.text;
                _matkul.ruangan = _editruanganMatkulController.text;

                var result = await _matkulService.updateMatkul(_matkul);
                if (result > 0) {
                  print(result);
                  Navigator.pop(context);
                  getAllMatkul();
                  _showSuccessSnackBar(const Text('Berhasil Update Data'));
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child:
                  const Text("Update", style: TextStyle(color: Colors.white)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text(
            'Edit Mata Kuliah',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _editnamaMatkulController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Mata Kuliah Baru',
                    labelText: 'Mata Kuliah',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _editnamaDosenController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Dosen Pengampu Kuliah Baru',
                    labelText: 'Dosen Pengampu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _edithariMatkulController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Hari',
                    labelText: 'Hari',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _selectTime(context, 'start');
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _editjamMulaiMatkulController,
                            decoration: InputDecoration(
                              hintText: 'Jam Mulai',
                              labelText: 'Start',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.access_time),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _selectTime(context, 'end');
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _editjamBerakhirMatkulController,
                            decoration: InputDecoration(
                              hintText: 'Jam Berakhir',
                              labelText: 'End',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.access_time),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _editruanganMatkulController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Ruangan',
                    labelText: 'Ruangan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _deleteFormDialog(BuildContext context, matkulId) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                var result = await _matkulService.deleteMatkul(matkulId);
                if (result > 0) {
                  print(result);
                  Navigator.pop(context);
                  getAllMatkul();
                  _showSuccessSnackBar(const Text('Berhasil Menghapus Data'));
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child:
                  const Text("Delete", style: TextStyle(color: Colors.white)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text(
            'Apakah anda yakin untuk menghapus ini?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Future<void> _selectTime(BuildContext context, String type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      String formattedTime = picked.format(context);
      if (type == 'start') {
        setState(() {
          jamMulai = formattedTime;
          _jamMulaiMatkulController.text = formattedTime;
        });
      } else {
        setState(() {
          jamBerakhir = formattedTime;
          _jamBerakhirMatkulController.text = formattedTime;
        });
      }
      print('Waktu yang dipilih: $formattedTime');
    }
  }
}
