import 'package:flutter/material.dart';
import 'package:tugas_13_bayu/database/dbHelper.dart';
import 'package:tugas_13_bayu/main/home.dart';
import 'package:tugas_13_bayu/model/fungsi.dart';
import 'package:tugas_13_bayu/model/modelFile.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  // final ControlAll controlAll = ControlAll();
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
      appBar: AppBar(
        title: Text('Tambah Product'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          TextField(
            controller: productController,
            decoration: InputDecoration(
              hintText: 'Nama',
              filled: true,
              fillColor: Color(0xFFE6F0EA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xff789262), width: 1),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: hargaController,
            decoration: InputDecoration(
              hintText: 'Harga',
              filled: true,
              fillColor: Color(0xFFE6F0EA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xff789262), width: 1),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: descController,
            decoration: InputDecoration(
              hintText: 'Deskripsi',
              filled: true,
              fillColor: Color(0xFFE6F0EA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xff789262), width: 1),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: gambarController,
            decoration: InputDecoration(
              hintText: 'Upload Gambar Product',
              filled: true,
              fillColor: Color(0xFFE6F0EA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xff789262), width: 1),
              ),
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(onPressed: simpanData, child: Text('Simpan')),

          ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              setState(() {
                muatData();
              });
            },
            child: Text('pindah'),
          ),
        ],
      ),
    );
  }
}
