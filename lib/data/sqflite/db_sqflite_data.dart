// ignore_for_file: depend_on_referenced_packages

import 'package:my_sqflite/data/class/user_class_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'users.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users (id INTEGER PRIMARY KEY, nombre TEXT, apellido TEXT, correo TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<List<Users>> users() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> usersMap = await database.query("users");

    //Esta parte es el Build de los datos que entan agregados dentro de la base datos _oponDB()
    return List.generate(
      usersMap.length,
      (i) => Users(
        id: usersMap[i]['id'],
        nombre: usersMap[i]['nombre'],
        apellido: usersMap[i]['apellido'],
        correo: usersMap[i]['correo'],
      ),
    );
  }

  // Insertar datos en la base de datos _openDB();
  static Future<dynamic> insert(Users users) async {
    // Esto es la conexion a la base de dato llamda _openDB()
    Database database = await _openDB();
    return database.insert("users", users.toMap());
  }

  //Modificacion de los datos en la base de dato
  static Future<dynamic> update(Users users) async {
    // Esto es la conexion a la base de dato llamda _openDB()
    Database database = await _openDB();
    return database
        .update("users", users.toMap(), where: "id = ?", whereArgs: [users.id]);
  }

  //Eliminacion del dato selecionado de la base de datos _openDB()
  static Future<dynamic> delete(Users users) async {
    // Esto es la conexion a la base de dato llamda _openDB()
    Database database = await _openDB();
    return database.delete("users", where: "id = ?", whereArgs: [users.id]);
  }

  // Este es otro metodo de como insertal, eliminar, actualizar los datos de la base datos
  // Comandos basados en sentecias SQL
  // rawInsert(SQL)
  // rawDelete(SQL)
  // rawUpdate(SQL)
  // rawQuery(SQL)
  //
  //Con sentencias

  static Future<void> insert2(Users users) async {
    Database database = await _openDB();
    await database.rawInsert(
      "INSERT INTO users (id, nombre, apellido, correo) VALUES (?, ?, ?, ?)",
      [users.id, users.nombre, users.apellido, users.correo],
    );
  }
}
