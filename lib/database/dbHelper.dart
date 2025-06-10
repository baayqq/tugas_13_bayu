import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tugas_13_bayu/model/modelFile.dart';

class Dbhelper {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'product.db'),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE product(id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, email TEXT, product TEXT, harga INTEGER, password TEXT)''',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertProduct(Product product) async {
    final db = await Dbhelper.db();
    await db.insert(
      'product',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Product>> getallProduct() async {
    final db = await Dbhelper.db();
    final List<Map<String, dynamic>> maps = await db.query('product');

    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }
}
