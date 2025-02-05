import 'dart:async';

import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      bloco TEXT,
      tipodabike TEXT,
      marca TEXT,
      modelo TEXT,
      cor TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "database_name.db",
      version: 2, // Incremented version number
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
      onUpgrade: (sql.Database database, int oldVersion, int newVersion) async {
        if (oldVersion < newVersion) {
          await database.execute("DROP TABLE IF EXISTS data");
          await createTables(database);
        }
      },
    );
  }

  static Future<int> createData(String title, String bloco, String tipodabike,
      String marca, String modelo, String cor) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'bloco': bloco,
      'tipodabike': tipodabike,
      'marca': marca,
      'modelo': modelo,
      'cor': cor,
    };
    try {
      final id = await db.insert('data', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return id;
    } catch (e) {
      print("Error creating data: $e");
      return -1; // Indicating an error occurred
    }
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    try {
      return await db.query('data', orderBy: 'id');
    } catch (e) {
      print("Error retrieving all data: $e");
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    try {
      return await db.query('data', where: "id = ?", whereArgs: [id], limit: 1);
    } catch (e) {
      print("Error retrieving single data: $e");
      return [];
    }
  }

  static Future<int> updateData(int id, String title, String bloco, String tipodabike,
      String marca, String modelo, String cor) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'bloco': bloco,
      'tipodabike': tipodabike,
      'marca': marca,
      'modelo': modelo,
      'cor': cor,
    };
    try {
      final result = await db.update('data', data, where: "id = ?", whereArgs: [id]);
      return result;
    } catch (e) {
      print("Error updating data: $e");
      return -1; // Indicating an error occurred
    }
  }

  static Future<void> deleteData(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('data', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      print("Error deleting data: $e");
    }
  }
}
