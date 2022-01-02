import 'package:codornices/services/sqflite/dbhelpers.dart';

String codornis() {
  String codornis = '''
   CREATE TABLE Codornis(
    "${DBHelpers.codornisColumnId}" INTEGER PRIMARY KEY,
    "${DBHelpers.codornisColumnSemana}" INTEGER,
    "${DBHelpers.codornisColumnNumeroAves}" INTEGER,
    "${DBHelpers.codornisColumnAlimento}" TEXT,
    "${DBHelpers.codornisColumnCantidadAlimento}" DOUBLE,
    "${DBHelpers.codornisColumnHuevos}" INTEGER,
    "${DBHelpers.codornisColumnAvesMuertas}" INTEGER
  );
  ''';
  return codornis;
}

String usuario() {
  String usuario = '''
CREATE TABLE Usuario(
    "${DBHelpers.usuarioColumnId}" INTEGER PRIMARY KEY,
    "${DBHelpers.usuarioColumnUsername}" TEXT,
    "${DBHelpers.usuarioColumnPassword}" TEXT
  );  
  ''';
  return usuario;
}
