import '../database/db_helper.dart';
import '../models/destination.dart';

class DestinationRepository {
  final DBHelper _dbHelper = DBHelper();

  Future<List<Destination>> getDestinations() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('destinations');

    return List.generate(maps.length, (i) {
      return Destination.fromMap(maps[i]);
    });
  }

  Future<void> insertDestination(Destination destination) async {
    final db = await _dbHelper.database;
    await db.insert('destinations', destination.toMap());
  }

  Future<void> updateDestination(Destination destination) async {
    final db = await _dbHelper.database;
    await db.update(
      'destinations',
      destination.toMap(),
      where: 'id = ?',
      whereArgs: [destination.id],
    );
  }

  Future<void> deleteDestination(int id) async {
    final db = await _dbHelper.database;
    await db.delete('destinations', where: 'id = ?', whereArgs: [id]);
  }
}
