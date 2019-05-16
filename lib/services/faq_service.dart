import 'package:sb_pedia/entities/faq.dart';
import 'package:sb_pedia/persistance/db_provider.dart';
import 'package:sb_pedia/services/network_service.dart';
import 'package:sqflite/sqflite.dart';


class FaqService extends NetworkService{

  static Future<void> addCategory(Faq faq) async {
    final Database db = await DbProvider.db.database;
    db.insert(Faq.table, faq.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Faq>> getFaqs ({String catId}) async {
    final Database db = await DbProvider.db.database;
    List<Map<String, dynamic>> _maps;
    if(catId != null){
      _maps = await db.rawQuery("SELECT * FROM ${Faq.table} WHERE categories LIKE '%${catId}%'");
    }else{
      _maps = await db.query('faqs');
    }


    return List.generate(_maps.length, (i) {

      return Faq(
          id: _maps[i]['id'],
          question: _maps[i]['question'],
          answer: _maps[i]['answer'],
          tags: _maps[i]['tags'],
          categories: _maps[i]['categories']
      );
    });
  }

  static Future<List<Faq>> getFaqsWhereIdIn(List ids) async {
    final Database db = await DbProvider.db.database;
    List<Map<String, dynamic>> _maps;
    String whereIds = "("+ids.join(",")+")";
    _maps = await db.rawQuery("SELECT * FROM ${Faq.table} WHERE id IN ${whereIds}");

    return List.generate(_maps.length, (i){
      return Faq(
        id: _maps[i]['id'],
        question: _maps[i]['question'],
        answer: _maps[i]['answer'],
        tags: _maps[i]['tags'],
        categories: _maps[i]['categories']
      );
    });
  }

  @override
  T extractFromJson<T>(Map<String, dynamic> parsedJson) {
    try{

      if(parsedJson == null){
        return null;
      }
      var faqs = parsedJson[Faq.table].cast<Map<String,dynamic>>();
      return faqs.map<Faq>((json) {
        return Faq.fromJson(json);
      }).toList();

    } on Exception catch(e){

      return null;
    }
  }
}