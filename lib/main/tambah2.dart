// import 'package:bayuppkd_b_2/Tugas_11&12/CancelOrder.dart';
// import 'package:bayuppkd_b_2/Tugas_11&12/Model11.dart';
// import 'package:flutter/material.dart';
// import 'package:bayuppkd_b_2/Tugas_11&12/DB_Helper11.dart';

// class TugasSebelas extends StatefulWidget {
//   const TugasSebelas({super.key});

//   @override
//   State<TugasSebelas> createState() => _TugasSebelasState();
// }

// class _TugasSebelasState extends State<TugasSebelas> {
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController namaController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController tiketController = TextEditingController();
//   final TextEditingController asalController = TextEditingController();

//   List<Pengunjung> daftarPengunjung = [];
//   String? isSelected;
//   TimeOfDay? selectedTime;

//   final List<String> _categories = [
//     "Avenger Infinity War",
//     "Jumbo",
//     "Transformers Last Knight",
//     "Final Destination 4",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     muatData();
//   }

//   Future<void> muatData() async {
//     final data = await DBHelperSebelas.getAllPengunjung();
//     setState(() {
//       daftarPengunjung = data;
//     });
//   }

//   Future<void> simpanData() async {
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

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Loket Pembelian Tiket Bioskop',
//           style: TextStyle(color: Color(0xffffffff)),
//         ),
//         backgroundColor: Color(0xff274d60),
//       ),
//       backgroundColor: Color(0xff6ba3be),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: namaController,
//               decoration: InputDecoration(
//                 hintText: 'Nama',
//                 filled: true,
//                 fillColor: Color(0xFFE6F0EA),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Color(0xff789262), width: 1),
//                 ),
//               ),
//             ),
//             SizedBox(height: 8),
//             DropdownButtonFormField<String>(
//               value: isSelected,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Color(0xFFE6F0EA),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Color(0xff789262), width: 1),
//                 ),
//               ),
//               hint: Text("Pilih Film"),
//               items:
//                   _categories.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   isSelected = value!;
//                   emailController.text = value; // Set nilai ke controller
//                 });
//               },
//             ),

//             SizedBox(height: 8),
//             TextField(
//               controller: tiketController,
//               decoration: InputDecoration(
//                 hintText: 'Jumlah Tiket',
//                 filled: true,
//                 fillColor: Color(0xFFE6F0EA),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Color(0xff789262), width: 1),
//                 ),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 8),
//             GestureDetector(
//               onTap: () async {
//                 final TimeOfDay? picked = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );
//                 if (picked != null) {
//                   setState(() {
//                     selectedTime = picked;
//                     asalController.text = picked.format(context); // Format jam
//                   });
//                 }
//               },
//               child: AbsorbPointer(
//                 child: TextField(
//                   controller: asalController,
//                   decoration: InputDecoration(
//                     hintText: 'Waktu',
//                     filled: true,
//                     fillColor: Color(0xFFE6F0EA),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: Color(0xff789262),
//                         width: 1,
//                       ),
//                     ),
//                     suffixIcon: Icon(Icons.access_time),
//                   ),
//                   readOnly: true,
//                 ),
//               ),
//             ),
//             // TextField(
//             //   controller: asalController,
//             //   decoration: InputDecoration(
//             //     hintText: 'Waktu',
//             //     filled: true,
//             //     fillColor: Color(0xFFE6F0EA),
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(12),
//             //       borderSide: BorderSide(color: Color(0xff789262), width: 1),
//             //     ),
//             //   ),
//             // ),
//             SizedBox(height: 36),
//             ElevatedButton(onPressed: simpanData, child: Text('Simpan')),
//             Divider(height: 32),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: daftarPengunjung.length,
//                 itemBuilder: (context, index) {
//                   final Pengunjung = daftarPengunjung[index];
//                   return Card(
//                     child: ListTile(
//                       onTap: () {},
//                       leading: CircleAvatar(child: Text('${index + 1}')),
//                       title: Text(Pengunjung.nama),
//                       subtitle: Text(
//                         'Film: ${Pengunjung.email}\nTiket: ${Pengunjung.tiket}\nWaktu: ${Pengunjung.asal}',
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => COrder()),
//                 );
//                 setState(() {
//                   muatData();
//                 });
//               },
//               child: Text('Ubah Pesanan'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
