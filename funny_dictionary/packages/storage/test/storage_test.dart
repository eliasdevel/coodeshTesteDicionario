import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:storage/storage.dart';

void main() {
  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
    await Storage.initialize();
  });

  test('Insert', () async {
    int? id = await Storage.save(StorageTable.words, {
      'name': 'dictionary',
      'insert_time': DateTime.now().millisecondsSinceEpoch
    });

    expect(id, greaterThanOrEqualTo(1));

    await Storage.save(StorageTable.words, {
      'name': 'apple',
      'insert_time': DateTime.now().millisecondsSinceEpoch
    });

    await Storage.save(StorageTable.words, {
      'name': 'orange',
      'insert_time': DateTime.now().millisecondsSinceEpoch
    });

    await Storage.save(StorageTable.words, {
      'name': 'juice',
      'insert_time': DateTime.now().millisecondsSinceEpoch
    });

    await Storage.save(StorageTable.words, {
      'name': 'Juice',
      'insert_time': DateTime.now().millisecondsSinceEpoch
    });
  });

  test('Update', () async {
    int? rowsAffected = await Storage.save(StorageTable.words,
        {'name': 'New', 'insert_time': DateTime.now().millisecondsSinceEpoch},
        id: 1);
    expect(rowsAffected, 1);
    var resutl = await Storage.query(StorageTable.words,
        filter: StorageFilter(columns: ['id'], arguments: [1]));

    expect(resutl?.first['name'], 'New');
  });

  test('Delete', () async {
    await Storage.delete(StorageTable.words, id: 2);

    var resutl = await Storage.query(StorageTable.words,
        filter: StorageFilter(columns: ['id'], arguments: [2]));

    expect(resutl, []);
  });

  test('Search', () async {
    var result = await Storage.query(StorageTable.words,
        filter: StorageFilter(
            columns: ['name'], arguments: ['%ju%'], operator: ' LIKE '));

    expect(result?.length, greaterThanOrEqualTo(2));
  });
}
