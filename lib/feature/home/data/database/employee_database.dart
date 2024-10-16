import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:jadiin_crud/feature/home/data/model/employee.dart';
import 'package:sqflite/sqflite.dart';

@immutable
class EmployeeDatabase {
  static const String _databaseName = "employee.db";
  static const int _databaseVersion = 1;

  const EmployeeDatabase._privateConstructor();
  static const EmployeeDatabase instance =
      EmployeeDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = "$path/$_databaseName";
    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
        CREATE TABLE IF NOT EXISTS $employeeTable (
          ${EmployeeFields.id} $idType,
          ${EmployeeFields.name} $textType,
          ${EmployeeFields.nip} $textType
        )
      ''');
  }

  Future<Employee> insert(Employee employee) async {
    final db = await database;
    final id = await db.insert(
      employeeTable,
      employee.toJson(),
    );

    return employee.copy(id: id);
  }

  Future<List<Employee>> readEmployees() async {
    final db = await database;
    final result = await db.query(employeeTable);
    return result.map((json) => Employee.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(
      employeeTable,
      where: '${EmployeeFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<Employee> readEmployee(int id) async {
    final db = await database;
    final result = await db.query(
      employeeTable,
      columns: EmployeeFields.values,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Employee.fromJson(result.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> update(Employee employee) async {
    final db = await database;
    return await db.update(
      employeeTable,
      employee.toJson(),
      where: '${EmployeeFields.id} = ?',
      whereArgs: [employee.id],
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
