import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../../../core.dart';
import '../../infra/drivers/local_storage_drive.dart';

class LocalStorageDriver extends ILocalStorageDriver with Disposable {
  static Database? _db;

  @override
  Future<Either<Exception, Unit>> createStorage() async {
    log(await getDatabasesPath());
    if (_db == null) {
      final String path = await getDatabasesPath();
      _db = await openDatabase('$path/base_app.db', version: 1);
    }

    if (_db == null) {
      return Left(Exception('error starting database'));
    }
    await _db?.execute('PRAGMA foreign_keys = ON;');
    return const Right(unit);
  }

  @override
  Future<Either<Exception, Unit>> deleteStorage() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> insert({required String query}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> insertAll({required String query}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> select({required String query}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> selectBy({required String query}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> execute({required String query}) async {
    try {
      if (_db == null) {
        return Left(Exception('Database not initialized'));
      }
      await _db!.execute('PRAGMA foreign_keys = ON;');
      await _db!.execute(query);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('LocalStorageDriver().execute: $e'));
    }
  }

  @override
  void dispose() async {
    if (_db != null) {
      await _db!.close();
    }
  }
}
