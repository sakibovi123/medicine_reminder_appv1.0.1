import 'dart:io';

import 'package:medicine/models/todo_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class TodoDBHelper{
  static final TodoDBHelper instance = TodoDBHelper._instance();
  static Database _db;

  TodoDBHelper._instance();

  String taskTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';


  Future<Database> get db async{
    if(_db == null) {
      _db = await _initDb();
    }

    return _db;
  }
  
  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todo_list.db";
    final todoListDB = await openDatabase(path, version: 1, onCreate: _createDb);
    
    return todoListDB;
  }
  
  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE $taskTable($colId INTEGER PRIMARY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(taskTable);
    return result;
  }

  Future<List<Todo>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Todo> taskList = [];

    taskMapList.forEach((taskMap) {
      taskList.add((Todo.fromMap(taskMap)));
    });

    return taskList;
  }



  Future <int> insertTask(Todo task) async{
    Database db = await this.db;
    final int result = await db.insert(taskTable, task.toMap());

    return result;
  }

  Future<int> updateTask(Todo task) async {
    Database db = await this.db;
    final int result = await db.update(
      taskTable,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );

    return result;
  }


  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      taskTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }




}