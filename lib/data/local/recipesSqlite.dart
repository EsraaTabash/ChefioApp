import 'package:recipe_book_application/data/models/recipeModel.dart';
import 'package:sqflite/sqflite.dart';

class Recipessqlite {
  static late final Database _database;
  static final String tableName = "recipes";
  static final String columnId = "id";
  static final String columnTitle = "title";
  static final String columnImage = "image";
  static final String columnDishTypes = "dishTypes";
  static final String columnHealthScore = "healthScore";
  static final String columnReadyInMinutes = "readyInMinutes";
  static final String columnSummary = "summary";
  static final String columnAggregateLikes = "aggregateLikes";

  static final String dbPath = "recipes.db";

  static Future<void> init() async {
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        print("DB Created");
        db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT,
            $columnImage TEXT,
            $columnDishTypes TEXT,
            $columnHealthScore REAL,
            $columnReadyInMinutes INTEGER,
            $columnSummary TEXT,
            $columnAggregateLikes INTEGER
          )
          ''');
      },
      onOpen: (db) {
        print('onOpen DB called');
      },
    );
  }

  static Future<int> insertRecipeToDb(Recipemodel recipe) async {
    int id = await _database.rawInsert('''
      INSERT INTO $tableName
      ($columnTitle, $columnImage, $columnDishTypes, $columnHealthScore, 
       $columnReadyInMinutes, $columnSummary, $columnAggregateLikes)
      VALUES(
        "${recipe.recipeName}",
        "${recipe.recipeImage}",
        "${recipe.recipeCategory}",
        "${recipe.recipeHealthScore}",
        "${recipe.recipeTime}",
        "${recipe.recipeDescription}",
        "${recipe.recipeAggregateLikes}"
      )
      ''');

    print("recipe inserted with id $id");
    return id;
  }

  static Future<List<Recipemodel>> getRecipesFromDb() async {
    var result = await _database.rawQuery('SELECT * FROM $tableName');
    print(result);

    List<Recipemodel> recipes = [];

    for (var map in result) {
      recipes.add(Recipemodel.fromJson(map));
    }

    return recipes;
  }

  static deleteRecipeFromDb(Recipemodel recipe) async {
    int result = await _database.rawDelete(
      'DELETE FROM $tableName WHERE $columnId = ${recipe.recipeId}',
    );

    print("recipe deleted $result");
  }

  static updateRecipeToDb(Recipemodel recipe) async {
    int result = await _database.rawUpdate('''
      UPDATE $tableName 
      SET 
        $columnTitle = "${recipe.recipeName}",
        $columnImage = "${recipe.recipeImage}",
        $columnDishTypes = "${recipe.recipeCategory}",
        $columnHealthScore = "${recipe.recipeHealthScore}",
        $columnReadyInMinutes = "${recipe.recipeTime}",
        $columnSummary = "${recipe.recipeDescription}",
        $columnAggregateLikes = "${recipe.recipeAggregateLikes}"
      WHERE 
        $columnId = ${recipe.recipeId}
      ''');

    print("recipe updated $result");
  }
}
