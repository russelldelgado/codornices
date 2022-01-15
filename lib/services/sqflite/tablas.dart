import 'package:codornices/services/sqflite/dbhelpers.dart';

String codornis() {
  String codornis = '''
   CREATE TABLE ${DBHelpers.tablaCodornis}(
    "${DBHelpers.codornisColumnId}" INTEGER PRIMARY KEY,
    "${DBHelpers.codornisColumnSemana}" TEXT,
    "${DBHelpers.codornisColumnNumeroAves}" INTEGER,
    "${DBHelpers.codornisColumnAlimento}" TEXT,
    "${DBHelpers.codornisColumnCantidadAlimento}" DOUBLE,
    "${DBHelpers.codornisColumnHuevos}" INTEGER,
    "${DBHelpers.codornisColumnAvesMuertas}" INTEGER,
    "${DBHelpers.codornisColumnUserId}" INTEGER,
    "${DBHelpers.codornisColumnprecioPorHuevo}" DOUBLE,
    "${DBHelpers.codornisColumnhuevosNoViables}" INTEGER,
    foreign key(${DBHelpers.codornisColumnUserId}) references ${DBHelpers.tablaUsuario}(${DBHelpers.usuarioColumnId})
  );
  ''';
  return codornis;
}

String usuario() {
  String usuario = '''
    CREATE TABLE ${DBHelpers.tablaUsuario}(
    "${DBHelpers.usuarioColumnId}" INTEGER PRIMARY KEY,
    "${DBHelpers.usuarioColumnUsername}" TEXT,
    "${DBHelpers.usuarioColumnPassword}" TEXT
  );  
  ''';
  return usuario;
}
