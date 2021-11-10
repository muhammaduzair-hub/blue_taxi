
import 'package:bluetaxiapp/data/model/adress_model.dart';
import 'package:bluetaxiapp/data/model/vehicles_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalApi{
  List<AdressModel> adressList =[];
  List<VehicleModel> vehicalList= [
    new VehicleModel(vName: "Standard", vid: 1, vPic: 'asset/icons/standard.png', vRate: "\$5", vArrivingTime: "3 min"),
    new VehicleModel(vName: "Van", vid: 2, vPic: 'asset/icons/van (1).png', vRate: "\$9", vArrivingTime: "5 min"),
    new VehicleModel(vName: "Exec", vid: 3, vPic: 'asset/icons/exec.png', vRate: "\$7", vArrivingTime: "6 min"),
    new VehicleModel(vName: "Electric ", vid: 4, vPic: 'asset/icons/electric.png', vRate: "\$5", vArrivingTime: "3 min"),
    new VehicleModel(vName: "Eco", vid: 5, vPic: 'asset/icons/eco.png', vRate: "\$7", vArrivingTime: "7 min"),
    new VehicleModel(vName: "Access", vid: 6, vPic: 'asset/icons/access.png', vRate: "\$5", vArrivingTime: "3 min"),
  ];

  LocalApi(){
    refreshAdresses();
  }

  void refreshAdresses() async{
    adressList = await AdressDatabase.instance.readAllNotes();
  }

  Future<List<AdressModel>> readAllAdresses() async{
    adressList = await AdressDatabase.instance.readAllNotes();
    return adressList;
  }

  Future<List<AdressModel>> addAdress ({required String title}) async{
    AdressModel taskModel = AdressModel(adressTitle: title);
    await AdressDatabase.instance.create(taskModel);
    adressList = await AdressDatabase.instance.readAllNotes();
    return adressList;
  }

  Future<bool> test()async{
    print("Succesfully");
    await Future.delayed(Duration(milliseconds: 1000));
    return true;
  }
}


class AdressDatabase {

  static final AdressDatabase instance = AdressDatabase._init();

  static Database? _database;

  AdressDatabase._init();

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
CREATE TABLE $tableAdress ( 
  ${AdressFields.id} $idType, 
  ${AdressFields.adressTitle} $textType
  )
''');
  }

  Future<AdressModel> create(AdressModel note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableAdress, note.toDictonary());
    return note.copy(id: id);
  }

  Future<bool> checkAdressFound(String title) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAdress,
      columns: AdressFields.values,
      where: '${AdressFields.id} = ?',
      whereArgs: [title],
    );

    if (maps.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<AdressModel> readNote(String title) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAdress,
      columns: AdressFields.values,
      where: '${AdressFields.id} = ?',
      whereArgs: [title],
    );

    if (maps.isNotEmpty) {
      return AdressModel.fromDictionary(maps.first);
    } else {
      throw Exception('ID $title not found');
    }
  }

  Future<List<AdressModel>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${AdressFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableAdress, orderBy: orderBy);

    return result.map((json) => AdressModel.fromDictionary(json)).toList();
  }

  Future<int> update(AdressModel task) async {
    final db = await instance.database;

    return db.update(
      tableAdress,
      task.toDictonary(),
      where: '${AdressFields.id} = ?',
      whereArgs: [AdressFields.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableAdress,
      where: '${AdressFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}