import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/detail_trx_model_db.dart';
import '../models/master_barang_db.dart';
import '../models/trx_model_db.dart';

class SQLHelper {
  static const _databaseName = "/penjualan.db";
  SQLHelper._privateConstructor();
  static final SQLHelper instance = SQLHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = await getDatabasesPath() + _databaseName;
    // print('db location : ' + dbPath);
    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE master_barang(
        kode_barang INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nama_barang STRING,
        harga_barang INTEGER,
        stok INTEGER,
        createdAt DATETIME
      )
      """);
    await db.execute("""CREATE TABLE tbl_detail_transaksi(
        no_trx STRING NOT NULL,
        kode_barang INTEGER NOT NULL,
        nama_barang STRING,
        harga_jual INTEGER,
        stok_awal INTEGER,
        total_item INTEGER,
        createdAt DATETIME
      )
      """);
    await db.execute("""CREATE TABLE tbl_transaksi(
        no_trx INTEGER PRIMARY KEY NOT NULL,
        total INTEGER,
        pembayaran INTEGER,
        kembali INTEGER,
        tanggal DATE,
        createdAt DATETIME
      )
      """);
  }

  Future<int> insertMasterBarang(MasterBarangDb todo) async {
    Database db = await instance.database;
    var res = await db.insert('master_barang', todo.toMap());
    return res;
  }

  Future<List<MasterBarangDb>> queryAllRows() async {
    Database db = await instance.database;
    var res =
        await db.query('master_barang', orderBy: "createdAt DESC", limit: 10);
    return res.map((json) => MasterBarangDb.fromJson(json)).toList();
  }

  Future<List<MasterBarangDb>> getItem(String nama) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT * FROM master_barang WHERE nama_barang LIKE '%$nama%' OR kode_barang LIKE '%$nama%'");
    // print(res);
    return res.map((json) => MasterBarangDb.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete('master_barang', where: 'kode_barang = ?', whereArgs: [id]);
  }

  clearTable() async {
    Database db = await instance.database;
    return await db.rawQuery(
        "DELETE FROM tbl_transaksi;DELETE FROM tbl_detail_transaksi;");
  }

  upadteMasterBarang(MasterBarangDb data) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        'UPDATE master_barang SET nama_barang = ?, harga_barang = ?, stok = ? WHERE kode_barang = ? ',
        [data.namaBarang, data.hargaBarang, data.stok, data.kodeBarang]);
  }

  Future<int> insertTrx(TrxDb trxlist) async {
    Database db = await instance.database;
    var res = await db.insert('tbl_transaksi', trxlist.toMap());
    return res;
  }

  Future<List<TrxDb>> queryAllTrx(String? tgl1, String? tgl2) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT A.*, SUM(B.total_item)total_item FROM tbl_transaksi A INNER JOIN tbl_detail_transaksi B ON B.no_trx = A.no_trx WHERE A.tanggal BETWEEN '$tgl1' AND '$tgl2'  GROUP BY A.no_trx ORDER BY A.createdAt DESC");
    return res.map((json) => TrxDb.fromJson(json)).toList();
  }

  Future<int> insertTrxDet(DetailTrxDb dettrxlist) async {
    Database db = await instance.database;
    var res = await db.insert('tbl_detail_transaksi', dettrxlist.toMap());
    return res;
  }

  Future<List<DetailTrxDb>> getItemTrx(String noTrx) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT A.*, B.total, B.pembayaran, B.kembali FROM tbl_detail_transaksi A INNER JOIN tbl_transaksi B ON B.no_trx = A.no_trx WHERE A.no_trx = '$noTrx'");
    // print(res);
    return res.map((json) => DetailTrxDb.fromJson(json)).toList();
  }

//   static Future<void> createTables(Database database) async {
//     await database.execute("""CREATE TABLE master_barang(
//         kode_barang INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//         nama_barang VARCHAR,
//         harga_barang INTEGER,
//         stok INTEGER
//       )
//       """);
//     await database.execute("""CREATE TABLE tbl_detail_transaksi(
//         no_trx VARCHAR NOT NULL,
//         kode_barang INTEGER NOT NULL,
//         nama_barang VARCHAR,
//         harga_jual INTEGER,
//         qty_awal INTEGER,
//         qty_trx INTEGER
//       )
//       """);
//     await database.execute("""CREATE TABLE tbl_transaksi(
//         no_trx INTEGER NOT NULL,
//         total INTEGER,
//         pembayaran INTEGER,
//         kembalian INTEGER,
//         tanggal DATE,
//         createdAt DATETIME NOT NULL
//       )
//       """);
//   }
// // id: the id of a item
// // title, description: name and description of your activity
// // created_at: the time that the item was created. It will be automatically handled by SQLite

//   static Future<Database> db() async {
//     return openDatabase(
//       'penjualan.db',
//       version: 1,
//       onCreate: (Database database, int version) async {
//         await createTables(database);
//       },
//     );
//   }

//   // Create new item (journal)
//   static Future<int> createMasterBarang(
//       String title, String? descrption) async {
//     final db = await SQLHelper.db();

//     final data = {'title': title, 'description': descrption};
//     final id = await db.insert('master_barang', data,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     return id;
//   }

//   // Read all items (journals)
//   static Future<List<Map<String, dynamic>>> getItems() async {
//     final db = await SQLHelper.db();
//     return db.query('items', orderBy: "id");
//   }

//   // Read a single item by id
//   // The app doesn't use this method but I put here in case you want to see it
//   static Future<List<Map<String, dynamic>>> getItem(int id) async {
//     final db = await SQLHelper.db();
//     return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
//   }

//   // Update an item by id
//   static Future<int> updateItem(
//       int id, String title, String? descrption) async {
//     final db = await SQLHelper.db();

//     final data = {
//       'title': title,
//       'description': descrption,
//       'createdAt': DateTime.now().toString()
//     };

//     final result =
//         await db.update('items', data, where: "id = ?", whereArgs: [id]);
//     return result;
//   }

//   // Delete
//   static Future<void> deleteItem(int id) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.delete("items", where: "id = ?", whereArgs: [id]);
//     } catch (err) {
//       debugPrint("Something went wrong when deleting an item: $err");
//     }
//   }
}
