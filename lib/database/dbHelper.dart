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
          'CREATE TABLE product(id INTEGER PRIMARY KEY AUTOINCREMENT, gambar TEXT, deskripsi TEXT, product TEXT, harga INTEGER)',
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

  static Future<void> updateProduct(Product product) async {
    // update
    final db = await Dbhelper.db();
    await db.update(
      'product',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  static Future<void> deleteProduct(int id) async {
    //delete
    final db = await Dbhelper.db();
    await db.delete('product', where: 'id = ?', whereArgs: [id]);

    // Cek apakah tabel kosong, lalu reset auto increment
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM product'),
    );
    if (count == 0) {
      await db.execute("DELETE FROM sqlite_sequence WHERE name = 'product'");
    }
  }
}
