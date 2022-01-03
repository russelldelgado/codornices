// ignore_for_file: file_names

import 'package:codornices/services/sqflite/dbhelpers.dart';
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

  static Future<List<Codornis>?> recuperarTodosLosCodornices() async {
    final db = await DBAVIPRO.db.database;
    final codornis = await db.query(DBAVIPRO.tablaCodornis);
    return codornis.isNotEmpty
        ? codornis.map((codornis) => Codornis.fromMap(codornis)).toList()
        : [];
  }

  static Future<List<Codornis>?> recuperar10Codornices() async {
    final db = await DBAVIPRO.db.database;
    final codornis = await db.query(DBAVIPRO.tablaCodornis, limit: 20);
    return codornis.isNotEmpty
        ? codornis.map((codornis) => Codornis.fromMap(codornis)).toList()
        : [];
  }

  static Future<List<Codornis>?> recuperarCodornicesEntreFechas(
      {required String fechaInicio, required String fechaFin}) async {
    String sql =
        "SELECT * from ${DBAVIPRO.tablaCodornis} where ${DBHelpers.codornisColumnSemana} >= Datetime('${fechaInicio}') and ${DBHelpers.codornisColumnSemana} <= Datetime('${fechaFin}')";
    final db = await DBAVIPRO.db.database;
    //final codornis = await db.query(DBAVIPRO.tablaCodornis);
    final codornis = await db.rawQuery(sql);

    print(sql);
    print(codornis);
    print(codornis.length);
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
