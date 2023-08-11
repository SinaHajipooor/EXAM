import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//------------------------------------------------------------------------------------------------------
class DatabaseHelper {
//--------------- feilds -----------------
  static const String _databaseName = 'Exams.db';
  // Private constructor
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;
//--------------- getter -----------------
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

//--------------- init database -----------------
  Future<Database> _initDatabase() async {
    // Get the path to the database file in assets
    final dbPath = await getDatabasesPath();
    final AssetBundle bundle = rootBundle;
    final asset = await bundle.load('assets/database/$_databaseName');

    // Copy the database from assets to the device
    final bytes = asset.buffer.asUint8List();
    final databasePath = join(dbPath, _databaseName);
    await File(databasePath).writeAsBytes(bytes);

    // Open the database
    return await openDatabase(
      databasePath,
      version: 1,
      readOnly: false,
    );
  }

  //---------------- user exams -----------------
  Future<List<Map<String, dynamic>>> getUserExams(String table) async {
    final db = await database;
    try {
      return await db.query(table);
    } catch (error) {
      print(error);
      throw error;
    } finally {
      // db.close();
    }
  }

  Future<void> updateUserExam(int examId, Map<String, dynamic> updatedData, String table) async {
    try {
      final db = await database;
      final rowsUpdated = await db.update(table, updatedData, where: 'examId = ?', whereArgs: [examId]);
      if (rowsUpdated > 0) {
        print('Updated row with id $examId in table $table');
      } else {
        print('No rows were updated');
      }
    } catch (error) {
      print('Error updating row with examId $examId in table $table: $error');
    }
  }

//------------- user exam questions -------------
  Future<List<Map<String, dynamic>>> getUserExamQuestions(String table, int examId) async {
    final db = await database;
    return await db.query(table, where: 'examId = ?', whereArgs: [examId]);
  }

  Future<void> updateUserExamQuestion(String table, Map<String, dynamic> updatedData, int questionId) async {
    try {
      final db = await database;
      final rowsUpdated = await db.update(table, updatedData, where: 'questionId = ?', whereArgs: [questionId]);
      if (rowsUpdated > 0) {
        print('Updated  row with id : $questionId in userExamQuestions');
      } else {
        print('no rows were updated in userExamQuestions table');
      }
    } catch (error) {
      print('Could not update a row in userExamQuestions table');
    }
  }

//------------- user exam questions answers -------------
  Future<List<Map<String, dynamic>>> getUserExamQuestionAnswers(String table, int questionId) async {
    final db = await database;
    return await db.query(table, where: 'questionId = ?', whereArgs: [questionId]);
  }
}
