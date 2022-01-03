// ignore_for_file: file_names

import 'package:codornices/models/usuario_model.dart';
import 'package:codornices/services/sqflite/dbGanvapp.dart';
import 'package:codornices/services/sqflite/dbhelpers.dart';

class UsuarioCRUDAVIPRO {
  static Future<int> nuevoUsuario(Usuario usuario) async {
    final db = await DBAVIPRO.db.database;
    final response = await db.insert(DBAVIPRO.tablaUsuario, usuario.toMap());
    return response;
  }

  static Future<Usuario?> recuperarUsuario(int id) async {
    final db = await DBAVIPRO.db.database;
    final response =
        await db.query(DBAVIPRO.tablaUsuario, where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Usuario.fromMap(response.first) : null;
  }

  static Future<Usuario?> recuperarUsuarioLogin(
      {required Usuario usuario}) async {
    final db = await DBAVIPRO.db.database;
    String sql =
        "SELECT * from ${DBAVIPRO.tablaUsuario} where ${DBHelpers.usuarioColumnUsername} == '${usuario.user}' and ${DBHelpers.usuarioColumnPassword} == '${usuario.password}'";

    final response = await db.rawQuery(sql);

    print(sql);
    print(response);
    print(response.length);
    // final response = await db.query(DBAVIPRO.tablaUsuario,
    //     where: "user = ? and password = ? ",
    //     whereArgs: [usuario.user, usuario.password]);
    return response.isNotEmpty ? Usuario.fromMap(response.first) : null;
  }

  static Future<List<Usuario>?> recuperarTodosLosUsuario() async {
    final db = await DBAVIPRO.db.database;

    final response = await db.query(DBAVIPRO.tablaUsuario);
    return response.isNotEmpty
        ? response.map((oferta) => Usuario.fromMap(oferta)).toList()
        : null;
  }

  static Future<int> updateUsuario(Usuario usuario) async {
    final db = await DBAVIPRO.db.database;
    final response = db.update(DBAVIPRO.tablaUsuario, usuario.toMap(),
        where: "id = ? ", whereArgs: [usuario.id]);
    return response;
  }

  static Future<int> deleteUsuario(int id) async {
    final db = await DBAVIPRO.db.database;
    final response = await db
        .delete(DBAVIPRO.tablaUsuario, where: "id = ?", whereArgs: [id]);
    return response;
  }

  static Future<int> deleteTodosUsuarios() async {
    final db = await DBAVIPRO.db.database;
    final response = await db.delete(DBAVIPRO.tablaUsuario);
    return response;
  }
}
