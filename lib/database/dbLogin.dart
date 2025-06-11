import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dblogin {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'masuk.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE masuk(id PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }
  
}
