import 'package:codornices/services/sqflite/dbGanvapp.dart';
import 'package:codornices/shared_preferences/preferencias_usuario.dart';

class Repo {
  static Future<void> inicializador() async {
    //iniciamos las preferencias de los usuarios
    Preferencias preferencias = new Preferencias();
    await preferencias.initPrefs();
    //iniciamos la base de datos
    await DBAVIPRO.db.initDB();
  }
}
