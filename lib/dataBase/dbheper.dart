import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static int _version = 2;
  static String _tablName = 'users';

  static initDataBase() async {
    if (_db != null) {
      print("database not Empty");
      return;
    } else {
      try {
        String path = await getDatabasesPath() + 'shoses.db';
        _db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, version) async {
            print("database creat");

            await db.execute(
                'CREATE TABLE $_tablName (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)');
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  static insertdb(String email, String password) async {
    int id = await _db!.rawInsert(
        'INSERT INTO $_tablName(email, password) VALUES(?, ?)',
        [email, password]);
    print('inserted1: $id');
  }

  static Future<List<Map>> printdb() async {
    return await _db!.rawQuery('SELECT * FROM $_tablName');
  }

  static deletedb(int id) async {
    int count =
        await _db!.rawDelete('DELETE FROM $_tablName WHERE id = ?', [id]);
  }
}
