
import 'package:bluetaxiapp/provider_practice/data/db_files/user_dto_fields.dart';
import 'package:bluetaxiapp/provider_practice/data/model/user_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDTODatabase {

  static final UserDTODatabase instance = UserDTODatabase._init();

  static Database? _database;

  UserDTODatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
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
CREATE TABLE $tableUser ( 
  ${UserDTOFields.id} $idType, 
  ${UserDTOFields.email} $textType,
  ${UserDTOFields.firstName} $textType,
  ${UserDTOFields.lastName} $textType
  )
''');
  }

  Future create(UserDTO note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(
        tableUser, note.toDictionary());

  }

  Future<UserDTO> readNote(String email) async {

    final db = await instance.database;

    final maps = await db.query(
      tableUser,
      columns: UserDTOFields.values,
      where: '${UserDTOFields.email} = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return UserDTO.fromDictionary(maps.first);
    } else {
      throw Exception('ID $email not found');
    }
  }

  Future<List<UserDTO>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${UserDTOFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableUser, orderBy: orderBy);

    return result.map((json) => UserDTO.fromDictionary(json)).toList();
  }

  Future<int> update(UserDTO task) async {
    final db = await instance.database;

    return db.update(
      tableUser,
      task.toDictionary(),
      where: '${UserDTOFields.email} = ?',
      whereArgs: [task.email],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUser,
      where: '${UserDTOFields.email} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}