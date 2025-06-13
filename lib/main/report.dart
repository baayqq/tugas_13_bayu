import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format Rupiah
import 'package:tugas_13_bayu/model/modelFile.dart';
import 'package:tugas_13_bayu/database/dbHelper.dart';
import 'dart:io';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int totalProduk = 0;
  int totalHarga = 0;
  List<Product> daftarProduk = [];

  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override 
  void initState() {
    super.initState();
    ambilData();
  }

  Future<void> ambilData() async {
    final data = await Dbhelper.getallProduct();
    int jumlahHarga = data.fold(0, (sum, item) => sum + (item.harga ?? 0));

    setState(() {
      daftarProduk = data;
      totalProduk = data.length;
      totalHarga = jumlahHarga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F8E9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16), // padding dalam container
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade100, // warna latar belakang
                border: Border.all(
                  color: Colors.green, // warna border
                  width: 2, // ketebalan border
                ),
                borderRadius: BorderRadius.circular(12), // sudut membulat
              ),
              child: Text(
                'Total Produk: $totalProduk\nTotal Harga: ${currencyFormat.format(totalHarga)}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Daftar Produk:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: daftarProduk.length,
                itemBuilder: (context, index) {
                  final item = daftarProduk[index];
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage:
                            item.gambar != null && item.gambar!.isNotEmpty
                                ? FileImage(File(item.gambar!)) as ImageProvider
                                : AssetImage('assets/images/default.jpg'),
                      ),
                      title: Text(
                        item.product ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(currencyFormat.format(item.harga ?? 0)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
