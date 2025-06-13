import 'package:flutter/material.dart';
import 'package:tugas_13_bayu/database/dbHelper.dart';
import 'package:tugas_13_bayu/model/modelFile.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  final String title;
  const EditPage({super.key, this.title = 'Edit'});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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

  Future<void> _pickNewImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        gambarController.text = pickedFile.path;
      });
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
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.70,
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
                              height: 100,
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
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Isi semua controller sebelum edit
                          productController.text = product.product;
                          hargaController.text = product.harga.toString();
                          descController.text = product.deskripsi;
                          gambarController.text = product.gambar;

                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text('Edit Produk'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: productController,
                                        decoration: InputDecoration(
                                          labelText: 'Nama Produk',
                                        ),
                                      ),
                                      TextField(
                                        controller: hargaController,
                                        decoration: InputDecoration(
                                          labelText: 'Harga',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        controller: descController,
                                        decoration: InputDecoration(
                                          labelText: 'Deskripsi',
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              gambarController.text.isNotEmpty
                                                  ? 'Gambar dipilih'
                                                  : 'Belum ada gambar',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: _pickNewImage,
                                            child: Text("Pilih Gambar"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Batal'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await Dbhelper.updateProduct(
                                          Product(
                                            id: product.id,
                                            product: productController.text,
                                            harga:
                                                int.tryParse(
                                                  hargaController.text,
                                                ) ??
                                                0,
                                            deskripsi: descController.text,
                                            gambar: gambarController.text,
                                          ),
                                        );
                                        Navigator.pop(context);
                                        muatData();
                                        ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Berhasil Edit Product",
                                                ),
                                                backgroundColor: Colors.teal,
                                              ),
                                            );
                                      },
                                      child: Text('Simpan'),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text(
                                    'Apakah anda yakin ingin\nmembatalkan pesanan?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Batal"),
                                    ),

                                    TextButton(
                                      onPressed: () async {
                                        await Dbhelper.deleteProduct(
                                          product.id!,
                                        );
                                        muatData();
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Berhasil Melakukan Pembatalan",
                                            ),
                                            backgroundColor: Colors.redAccent,
                                          ),
                                        );
                                      },
                                      child: Text("Lanjut"),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    ],
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
