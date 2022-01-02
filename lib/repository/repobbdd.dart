import 'package:codornices/services/sqflite/dbGanvapp.dart';

class Repo {
  static Future<void> inicializador() async {
    await DBAVIPRO.db.initDB();
  }
}
