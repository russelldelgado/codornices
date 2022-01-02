// ignore_for_file: file_names

import 'dart:io';
import 'package:codornices/models/codornis_model.dart';
import 'package:codornices/models/usuario_model.dart';
import 'package:codornices/services/sqflite/CRUD/codornisCrud.dart';
import 'package:codornices/services/sqflite/CRUD/usuarioCrud.dart';
import 'package:codornices/services/sqflite/tablas.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'dbhelpers.dart';

class DBAVIPRO {
  static const String nombreBBDD = DBHelpers.nombreBBDD;

  static const String tablaUsuario = DBHelpers.tablaUsuario;
  static const String tablaCodornis = DBHelpers.tablaCodornis;

  static Database? _database;
  static final DBAVIPRO db = DBAVIPRO._();
  DBAVIPRO._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  //orden de las llamadas > onCOnfigure > oncreate > onUpgrade > ondowngrade > onOpen > onConfigure

  Future<Database> initDB() async {
    //introducimos el path de donde almacenaremos la bbdd , el join nos sirve para unir partes de código que genera la ruta de la bbdd
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, nombreBBDD);
    //procedemos a la creación de nuestra bbdd

    return await openDatabase(
        //ruta donde se encuentra mi bbdd
        path,
        //version , solo hay que actualizarla cuando vayamos a cambiar tablas en nuestra bbdd
        version: 1,
        //esto es lo que pasa cuando se abre nuestra bbdd

        //esto es lo que pasa cuando se crea nuestra bbdd en este paso crearemos todas las tablas
        onCreate: (db, version) async {
          await db.execute(codornis());
          await db.execute(usuario());
        },
        onUpgrade: (db, oldVersion, newVersion) {},
        onOpen: (db) async {
          await db.getVersion();
        });
  }

  //estos métodos me sirven para trabajar directamente con los datos de mi Codornis sin tener que llamar a otra clase distinta de esta
  Future<int> insertarCodornis(Codornis codornis) async =>
      await CodornisCRUDDBAVIPRO.insertarCodornis(codornis);

  Future<Codornis?> recuperarCodornis(int id) async =>
      await CodornisCRUDDBAVIPRO.recuperarCodornis(id);

  Future<List<Codornis>?> recuperarTodosLosCodorniss() async =>
      await CodornisCRUDDBAVIPRO.recuperarTodosLosCodorniss();

  Future<int?> eliminarcodornis(int id) async =>
      await CodornisCRUDDBAVIPRO.eliminarcodornis(id);

  Future<int?> eliminarTodaLaBBDDDeCodornis() async =>
      await CodornisCRUDDBAVIPRO.eliminarTodaLaBBDDDeCodornis();

  //ESTOS METODOS SIRVEN PARA TRABAJAR CON LOS DATOS DEL USUARIO

  Future<int> nuevoUsuario(Usuario usuario) async =>
      await UsuarioCRUDAVIPRO.nuevoUsuario(usuario);

  Future<Usuario?> recuperarUsuario(int id) async =>
      await UsuarioCRUDAVIPRO.recuperarUsuario(id);

  Future<int> updateUsuario(Usuario usuario) async =>
      await UsuarioCRUDAVIPRO.updateUsuario(usuario);

  Future<List<Usuario>?> recuperarTodosLosUsuario() async =>
      UsuarioCRUDAVIPRO.recuperarTodosLosUsuario();

  Future<int> deleteTodosUsuarios() async =>
      UsuarioCRUDAVIPRO.deleteTodosUsuarios();
}
