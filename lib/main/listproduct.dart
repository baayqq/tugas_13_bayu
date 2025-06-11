import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_13_bayu/database/dbHelper.dart';
import 'package:tugas_13_bayu/main/edit.dart';
import 'package:tugas_13_bayu/main/tambah.dart';
import 'package:tugas_13_bayu/model/modelFile.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class ListProd extends StatefulWidget {
  final String title;
  const ListProd({super.key, this.title = 'Home'});

  @override
  State<ListProd> createState() => _ListProdState();
}

class _ListProdState extends State<ListProd> {
  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID', // kode lokal Indonesia
    symbol: 'Rp', // simbol Rupiah
    decimalDigits: 0, // tanpa angka di belakang koma
  );
  final TextEditingController productController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();

  List<Product> daftarProduct = [];

  @override
  void initState() {
    super.initState();
    muatData();
  }

  Future<void> muatData() async {
    final data = await Dbhelper.getallProduct();
    setState(() {
      daftarProduct = data;
    });
  }

  Future<void> simpanData() async {
    final product = productController.text;
    final harga = int.tryParse(hargaController.text) ?? 0;
    final desc = descController.text;
    final gambar = gambarController.text;

    if (product.isNotEmpty && harga > 0) {
      await Dbhelper.insertProduct(
        Product(
          product: product,
          harga: harga,
          deskripsi: desc,
          gambar: gambar,
        ),
      );
      productController.clear();
      hargaController.clear();
      descController.clear();
      gambarController.clear();
      muatData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F8E9),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        itemCount: daftarProduct.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.75, // Tinggi vs lebar (atur sesuai kebutuhan)
        ),
        itemBuilder: (context, index) {
          final product = daftarProduct[index];
          final gambarAda =
              product.gambar.isNotEmpty && File(product.gambar).existsSync();

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        gambarAda
                            ? Image.file(
                              File(product.gambar),
                              width: double.infinity,
                              height: 128,
                              fit: BoxFit.cover,
                            )
                            : Container(
                              width: double.infinity,
                              height: 100,
                              color: Colors.grey[300],
                              child: Icon(Icons.image, size: 40),
                            ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.product,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text('Harga: ${currencyFormat.format(product.harga ?? 0)}'),
                  SizedBox(height: 4),
                  Text(
                    product.deskripsi,
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
