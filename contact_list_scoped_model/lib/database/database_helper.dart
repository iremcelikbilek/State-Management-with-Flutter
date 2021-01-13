import 'dart:io';
import 'package:contact_list_scoped_model/models/kullanici.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper extends Model{
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    // Singleton Tasarım Kalıbı - Tek Nesne üretmek için kullanılır.
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._namedConstructor();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper._namedConstructor();

  Future<Database> _getDatabase() async {
    // Singleton Tasarım Kalıbı - Tek Nesne üretmek için kullanılır.
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initializeDatabase() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, "contact.db");

    bool exists = await databaseExists(path);

    if (!exists) {
      // Bu ifade "exists == false" demek
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        print('Directory oluşturulamadı.');
      }

      ByteData data = await rootBundle.load(join("assets", "contact.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path, readOnly: false);
  }

  Future<List<Map<String, dynamic>>> kullaniciGetir() async {
    var db = await _getDatabase();
    var sonuc = await db.query('kullanici');
    return sonuc;
  }

  Future<int> kullaniciEkle(Kullanici kullanici) async {
    var db = await _getDatabase();
    var sonuc = await db.insert('kullanici', kullanici.toMap());
    notifyListeners();
    return sonuc;
  }

  Future<int> kullaniciSil(int kullaniciID) async {
    var db = await _getDatabase();
    var sonuc = await db.delete('kullanici',
        where: "kullaniciID = ?", whereArgs: [kullaniciID]);
    notifyListeners();
    return sonuc;
  }

  Future<List<Kullanici>> kullaniciListesiniGetir() async {
    var kullaniciMapListesi = await kullaniciGetir();
    var kullaniciListesi = List<Kullanici>();
    for (Map map in kullaniciMapListesi) {
      kullaniciListesi.add(Kullanici.fromMap(map));
    }
    return kullaniciListesi;
  }

}
