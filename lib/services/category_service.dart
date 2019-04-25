import 'package:sb_pedia/entities/category.dart';
import 'package:sb_pedia/persistance/db_provider.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sqflite/sqflite.dart';


class CategoryService with NetworkService{

  static Future<void> addCategory(Category category) async {
    final Database db = await DbProvider.db.database;
    db.insert(Category.table, category.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Category>> getCategories () async {
    final Database db = await DbProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query('faq_categories',orderBy: "id asc");

    return List.generate(maps.length, (i) {

      return Category(
        id: maps[i]['id'],
        parentId: maps[i]['parent_id'],
        name: maps[i]['name'],
        alias: maps[i]['alias'],
        description: maps[i]['description']
      );
    });
  }

  @override
  T extractFromJson<T>(Map<String, dynamic> parsedJson) {

    try{
      if(parsedJson == null){
        return null;
      }
      var categories = parsedJson[Category.table].cast<Map<String,dynamic>>();
      return categories.map<Category>((json) {
        return Category.fromJson(json);
      }).toList();

    } on Exception catch(e){
      return null;
    }
  }
}