import 'package:ddstudy_ui/domain/db_model.dart';
import 'package:ddstudy_ui/domain/models/comment/comment.dart';
import 'package:ddstudy_ui/domain/models/comment/comment_stats.dart';
import 'package:ddstudy_ui/domain/models/post/post_attach.dart';
import 'package:ddstudy_ui/domain/models/post/post_searched.dart';
import 'package:ddstudy_ui/domain/models/post/post_subscribed.dart';
import 'package:ddstudy_ui/domain/models/user/subscribe_status.dart';
import 'package:ddstudy_ui/domain/models/user/user_activity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uuid/uuid.dart';

import '../../domain/models/post/post.dart';
import '../../domain/models/post/post_stats.dart';
import '../../domain/models/user/user.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static late Database _db;
  static bool _initialized = false;

  Future init() async {
    if (!_initialized) {
      var databasePath = await getDatabasesPath();
      var path = join(
        databasePath,
        "db_v1.0.8.db",
      );

      _db = await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
      );
      _initialized = true;
    }
  }

  Future _createDB(Database db, int version) async {
    var dbInitScript = await rootBundle.loadString('assets/db_init.sql');
    dbInitScript.split(';').forEach((element) async {
      if (element.isNotEmpty) {
        await db.execute(element);
      }
    });
  }

  static final _factories = <Type, Function(Map<String, dynamic> map)>{
    User: (map) => User.fromMap(map),
    UserActivity: (map) => UserActivity.fromMap(map),
    Post: (map) => Post.fromMap(map),
    PostAttach: (map) => PostAttach.fromMap(map),
    PostStats: (map) => PostStats.fromMap(map),
    PostSearched: (map) => PostSearched.fromMap(map),
    PostSubscribed: (map) => PostSubscribed.fromMap(map),
    Comment: (map) => Comment.fromMap(map),
    CommentStats: (map) => CommentStats.fromMap(map),
    SubscribeStatus: (map) => SubscribeStatus.fromMap(map),
  };

  String _dbName(Type type) {
    if (type == DBModel) {
      throw Exception("Type is REQUIRED");
    }
    return "t_$type";
  }

  Future<Iterable<Map<String, dynamic>>> getAllWithIncludes<T>(
    Map<JoinTableAndSelector, String> joinTablesWithSelectors, {
    Map<String, Object?>? whereMap,
    String? orderBy,
  }) async {
    String queryString = "SELECT * FROM ${_dbName(T)} ";
    joinTablesWithSelectors.forEach((key, value) {
      queryString +=
          "INNER JOIN ${_dbName(key.joinTable)} ON ${_dbName(T)}.$value = ${_dbName(key.joinTable)}.${key.selector} ";
    });
    if (whereMap != null) {
      queryString += "WHERE ";
      var whereBuilder = <String>[];
      whereMap.forEach((key, value) {
        whereBuilder.add("$key = \"${value.toString()}\"");
      });
      queryString += whereBuilder.join(' AND ');
    }
    if (orderBy != null) {
      queryString += " ORDER BY $orderBy";
    }
    Iterable<Map<String, dynamic>> query = await _db.rawQuery(queryString);

    return query;
  }

  Future<Iterable<T>> getAll<T extends DBModel>({
    Map<String, Object?>? whereMap,
    int? take,
    int? skip,
    String? orderBy,
  }) async {
    Iterable<Map<String, dynamic>> query;
    if (whereMap != null && whereMap.isNotEmpty) {
      var whereBuilder = <String>[];
      var whereArgs = <dynamic>[];

      whereMap.forEach((key, value) {
        if (value is Iterable<dynamic>) {
          whereBuilder
              .add("$key IN (${List.filled(value.length, '?').join(',')})");
          whereArgs.addAll(value.map((e) => "$e"));
        } else if (value is WhereCompareArg) {
          whereBuilder.add(
              "$key ${ComparisonOperators.operatorString[value.compareOper]} ?");
          whereArgs.add(value.arg);
        } else if (value is WhereNullCheckArg) {
          whereBuilder.add(
              "$key ${NullCheckOperators.operatorString[value.nullCheckOper]}");
        } else {
          whereBuilder.add("$key = ?");
          whereArgs.add(value);
        }
      });
      query = await _db.query(_dbName(T),
          offset: skip,
          limit: take,
          orderBy: orderBy,
          where: whereBuilder.join(' and '),
          whereArgs: whereArgs);
    } else {
      query = await _db.query(
        _dbName(T),
        orderBy: orderBy,
        offset: skip,
        limit: take,
      );
    }
    var resList = query.map((e) => _factories[T]!(e)).cast<T>();

    return resList;
  }

  Future<T?> get<T extends DBModel>(dynamic id) async {
    var res = await _db.query(_dbName(T), where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? _factories[T]!(res.first) : null;
  }

  Future<int> insert<T extends DBModel>(T model) async {
    if (model.id == "") {
      var modelmap = model.toMap();
      modelmap["id"] = const Uuid().v4();
      model = _factories[T]!(modelmap);
    }
    return await _db.insert(_dbName(T), model.toMap());
  }

  Future<int> update<T extends DBModel>(T model) async => await _db.update(
        _dbName(T),
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );

  Future<int> delete<T extends DBModel>(T model) async => await _db.delete(
        _dbName(T),
        where: "id = ?",
        whereArgs: [model.id],
      );

  Future<int> cleanTable<T extends DBModel>() async =>
      await _db.delete(_dbName(T));

  Future<int> createUpdate<T extends DBModel>(T model) async {
    var dbItem = await get<T>(model.id);
    var res = dbItem == null ? insert(model) : update(model);
    return await res;
  }

  Future insertRange<T extends DBModel>(Iterable<T> values) async {
    var batch = _db.batch();
    for (var row in values) {
      var data = row.toMap();
      if (row.id == "") {
        data["id"] = const Uuid().v4();
      }
      batch.insert(_dbName(T), data);
    }
    await batch.commit(noResult: true);
  }

  Future createUpdateRange<T extends DBModel>(Iterable<T> values,
      {bool Function(T oldItem, T newItem)? updateCond}) async {
    var batch = _db.batch();
    for (var row in values) {
      var dbItem = await get<T>(row.id);
      var data = row.toMap();
      if (row.id == "") {
        data["id"] = const Uuid().v4();
      }
      if (dbItem == null) {
        batch.insert(_dbName(T), data);
      } else if (updateCond == null || updateCond(dbItem, row)) {
        batch.update(
          _dbName(T),
          data,
          where: "id = ?",
          whereArgs: [row.id],
        );
      }
    }
    await batch.commit(noResult: true);
  }
}

enum ComparisonOperatorEnum { equal, notEqual, greater, less }

enum NullCheckOperatorEnum { isNull, isNotNull }

class WhereCompareArg {
  Object arg;
  ComparisonOperatorEnum compareOper;
  WhereCompareArg({
    required this.arg,
    required this.compareOper,
  });
}

class WhereNullCheckArg {
  NullCheckOperatorEnum nullCheckOper;
  WhereNullCheckArg({
    required this.nullCheckOper,
  });
}

class JoinTableAndSelector {
  Type joinTable;
  String selector;
  JoinTableAndSelector({
    required this.joinTable,
    required this.selector,
  });
}

class ComparisonOperators {
  static Map<ComparisonOperatorEnum, String> operatorString = {
    ComparisonOperatorEnum.equal: "=",
    ComparisonOperatorEnum.notEqual: "!=",
    ComparisonOperatorEnum.greater: ">",
    ComparisonOperatorEnum.less: "<",
  };
}

class NullCheckOperators {
  static Map<NullCheckOperatorEnum, String> operatorString = {
    NullCheckOperatorEnum.isNull: "IS NULL",
    NullCheckOperatorEnum.isNotNull: "IS NOT NULL",
  };
}
