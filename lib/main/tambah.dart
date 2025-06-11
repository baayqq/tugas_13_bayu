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
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.image),
                  label: Text('Pilih Gambar'),
                ),
                SizedBox(width: 12),
                if (_pickedImage != null)
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      image: DecorationImage(
                        image: FileImage(_pickedImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 16),
            ElevatedButton(onPressed: simpanData, child: Text('Simpan')),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListProd()),
                );
                setState(() {
                  muatData();
                });
              },
              child: Text('Pindah'),
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
