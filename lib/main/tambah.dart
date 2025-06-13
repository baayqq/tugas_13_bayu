import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Tambahkan ini
import 'package:path_provider/path_provider.dart';
import 'package:tugas_13_bayu/database/dbHelper.dart';
import 'package:tugas_13_bayu/main/listproduct.dart';
import 'package:tugas_13_bayu/model/modelFile.dart';

class AddProduct extends StatefulWidget {
  final String title;
  const AddProduct({super.key, this.title = 'Add'});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  File? _pickedImage; // Ganti TextField untuk gambar

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, // Kompres gambar, makin kecil makin hemat memori
    );

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> simpanData() async {
    final product = productController.text;
    final harga = int.tryParse(hargaController.text) ?? 0;
    final desc = descController.text;
    final gambar = _pickedImage?.path ?? ''; // simpan path gambar

    if (product.isNotEmpty &&
        harga > 0 &&
        gambar.isNotEmpty &&
        File(gambar).existsSync()) {
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
      setState(() {
        _pickedImage = null;
      });
      muatData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F8E9),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: productController,
              decoration: inputDecoration('Nama'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: hargaController,
              decoration: inputDecoration('Harga'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            TextField(
              controller: descController,
              decoration: inputDecoration('Deskripsi'),
            ),
            SizedBox(height: 8),

            // Upload Gambar Button
            Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.grey[300],
                    ),
                    child:
                        _pickedImage != null
                            ? Image.file(_pickedImage!, fit: BoxFit.cover)
                            : Icon(Icons.image_outlined, size: 40),
                  ),
                ),
                Text('masukan gambar'),
              ],
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                simpanData();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Berhasil menambahkan produk produk"),
                    backgroundColor: Colors.teal,
                  ),
                );
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Color(0xFFE6F0EA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xff789262), width: 1),
      ),
    );
  }
}
