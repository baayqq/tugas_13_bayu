import 'dart:convert';

class Product {
  final int? id;
  final String product;
  final String deskripsi;
  final int harga;
  final String gambar;

  Product({
    this.id,
    required this.product,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'deskripsi': deskripsi,
      'harga': harga,
      'gambar': gambar,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      product: map['product'],
      deskripsi: map['deskripsi'],
      harga: map['harga'],
      gambar: map['gambar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
