import 'package:flutter/material.dart';

class ControlAll {
  final TextEditingController idController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();
  final TextEditingController descController = TextEditingController();
}

// Future<void> simpanData() async {
//     final id = int.tryParse(idController.text);
//     final nama = namaController.text;
//     final email = emailController.text;
//     final tiket = int.tryParse(tiketController.text) ?? 0;
//     final asal = asalController.text;

//     if (nama.isNotEmpty && tiket > 0) {
//       await DBHelperSebelas.insertPengunjung(
//         Pengunjung(id: id, nama: nama, email: email, tiket: tiket, asal: asal),
//       );
//       idController.clear();
//       namaController.clear();
//       emailController.clear();
//       tiketController.clear();
//       asalController.clear();
//       await muatData();
//       setState(() {
//         isSelected = null;
//         selectedTime = null;
//       });

//       // setState(() {});
//     }
//   }
