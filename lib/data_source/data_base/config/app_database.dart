import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'encrypt_codec.dart';

@singleton
class AppDatabase {
  Database? _db;
  static AppDatabase? _singleton;

  factory AppDatabase() {
    if (_singleton == null) {
      _singleton = AppDatabase?._();
    }
    return _singleton!;
  }
  AppDatabase._();

  Future init() async {
    if (_db == null) {
      _db = await _setupDataBase('pc', false);
    }
  }

  Future<Database> _setupDataBase(String dbName, bool encrypted) async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    var dbPath = '${appDocDirectory.path}/$dbName.db';
    var dbFactory = databaseFactoryIo;

    var codec;
    if (encrypted) {
      codec = getEncryptSembastCodec(password: '8dE1WfccA41r');
    }
    return await dbFactory.openDatabase(dbPath, codec: codec);
  }

  Database get myDatabase {
    return _db!;
  }

  Future<Database> get database async {
    if (_db == null) {
      _db = await _setupDataBase('pc', false);
    }
    return _db!;
  }

  Future deleteDatabase() async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    await databaseFactoryIo.deleteDatabase('${appDocDirectory.path}/pc.db');
    _db!.close();
  }
}
