// ignore_for_file: file_names

import 'package:sqflite/sql.dart';

import 'package:codornices/models/codornis_model.dart';
import 'package:codornices/services/sqflite/dbGanvapp.dart';

class CodornisCRUDDBAVIPRO {
  static Future<int> insertarCodornis(Codornis codornis) async {
    final db = await DBAVIPRO.db.database;
    return await db.insert(DBAVIPRO.tablaCodornis, codornis.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Codornis?> recuperarCodornis(int id) async {
    final db = await DBAVIPRO.db.database;
    final codornis = await db
        .query(DBAVIPRO.tablaCodornis, where: 'id = ?', whereArgs: [id]);
    return codornis.isNotEmpty ? Codornis.fromMap(codornis.first) : null;
  }

  static Future<int> updateCodornis(Codornis codornis) async {
    final db = await DBAVIPRO.db.database;
    final response = db.update(DBAVIPRO.tablaCodornis, codornis.toMap(),
        where: "id = ? ", whereArgs: [codornis.id]);
    return response;
  }

  static Future<List<Codornis>?> recuperarTodosLosCodorniss() async {
    final db = await DBAVIPRO.db.database;
    final codornis = await db.query(DBAVIPRO.tablaCodornis);
    return codornis.isNotEmpty
        ? codornis.map((codornis) => Codornis.fromMap(codornis)).toList()
        : [];
  }

  static Future<int?> eliminarcodornis(int id) async {
    final db = await DBAVIPRO.db.database;
    return await db
        .delete(DBAVIPRO.tablaCodornis, where: 'id = ? ', whereArgs: [id]);
  }

  static Future<int?> eliminarTodaLaBBDDDeCodornis() async {
    final db = await DBAVIPRO.db.database;
    return await db.delete(DBAVIPRO.tablaCodornis);
  }
}
