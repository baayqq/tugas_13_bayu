import 'package:flutter/material.dart';
import 'package:tugas_13_bayu/database/dbHelper.dart';
import 'package:tugas_13_bayu/model/modelFile.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
