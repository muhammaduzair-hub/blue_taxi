
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabase {

  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $userTable ( 
  ${UserField.id} $textType, 
  ${UserField.name} $textType,
  ${UserField.email} $textType,
  ${UserField.phoneno} $textType,
  ${UserField.address} $textType,
  ${UserField.type} $textType
  )
''');
  }

  Future create(UserModel note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(userTable, note.toDictionary());

  }

  Future<UserModel> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      userTable,
      columns: UserField.values,
      where: '${UserField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromDictionary(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<UserModel>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${UserField.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(userTable, orderBy: orderBy);

    return result.map((json) => UserModel.fromDictionary(json)).toList();
  }

  Future<int> update(UserModel task) async {
    final db = await instance.database;

    return db.update(
      userTable,
      task.toJson(),
      where: '${UserField.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete() async {
    final db = await instance.database;

    return await db.delete(
      userTable
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}