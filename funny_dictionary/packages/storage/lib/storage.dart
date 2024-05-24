library storage;

import 'package:sqflite/sqflite.dart';

/// Storage class to use in a specific project funnyDictionary
class Storage {
  static Database? db;
  static Future<void> initialize() async {
    db = await openDatabase('dictionary.db');
    await _createTables();
  }

  static Future<void> _createTables() async {
    for (final sql in _tables) {
      await db?.execute(sql);
    }
  }

  static final List<String> _tables = [
    'CREATE TABLE IF NOT EXISTS ${StorageTable.favoriteWords.name} (id INTEGER PRIMARY KEY, name TEXT, insert_time INTEGER )',
    'CREATE TABLE IF NOT EXISTS ${StorageTable.cachedWords.name} (id INTEGER PRIMARY KEY, name TEXT, server_data BLOB, insert_time INTEGER )'
  ];

  /// Function save recives table name data an for update cases optional filter param
  static Future<int?> save(StorageTable table, Map<String, dynamic> values,
      {int? id}) async {
    StorageFilter? filter;

    //if is id create filter
    if (id != null) {
      filter = idFilter(id);
    }

    //verify if exists data in db
    var result = await db?.query(table.name,
        where: filter?.getFilterWhere(), whereArgs: filter?.arguments);

    if (result != null && filter != null) {
      if (result.isNotEmpty) {
        //Update if exists data
        return await db?.update(table.name, values,
            where: filter.getFilterWhere(), whereArgs: filter.arguments);
      }
    }

    return db?.insert(table.name, values);
  }

  static Future<int?> delete(StorageTable table,
      {int? id, StorageFilter? filter}) async {
    if (id != null) {
      filter = idFilter(id);
    }

    if (filter == null) {
      throw Exception("Not avaliable to delete withaut filter");
    }

    return db?.delete(table.name,
        where: filter.getFilterWhere(), whereArgs: filter.arguments);
  }

  static StorageFilter idFilter(int id) {
    return StorageFilter(columns: ['id'], arguments: [id]);
  }

  static Future<List<Map<String, Object?>>?> query(StorageTable table,
      {StorageFilter? filter}) async {
    return db?.query(
      table.name,
      where: filter?.getFilterWhere(),
      whereArgs: filter?.arguments,
    );
  }

  static Future<List<Map<String, Object?>>?> rawQuery(String sql) async {
    return await db?.rawQuery(sql);
  }
}

class StorageFilter {
  StorageFilter(
      {required this.columns,
      this.arguments,
      this.glue = " AND ",
      this.operator = " = ",
      this.comparer = " ? "});
  final List<String> columns;
  final List<Object?>? arguments;
  final String glue;
  final String operator;
  final String comparer;
  String getFilterWhere() {
    return columns.map((e) => "$e$operator$comparer").toList().join(glue);
  }
}

enum StorageTable { favoriteWords, cachedWords }
