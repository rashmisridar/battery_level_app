// database_helper.dart
import 'package:battery_level_app/home/data/battery_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryLocalDataSource {
  static Database? _database;
  static const String dbName = 'battery_data_base.db';
  static const String tableName = 'battery';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, '
                'batteryPercentage INTEGER,batteryCategory TEXT, timeStamp INTEGER )');
      },
    );
  }

  Future<int> insertBatteryData(BatteryModel batteryModel) async {
    Database db = await database;
    int status = await db.insert(tableName, batteryModel.toMap());
    return status;
  }

  Future<List<BatteryModel>> fetchBatteryHistory() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) {
      return BatteryModel.fromMap(maps[index]);
    });
  }
}
