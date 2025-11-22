import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_book_application/data/models/recipeModel.dart';

class Reciperepo {
  static const base = 'https://6915a0f984e8bd126afab6ec.mockapi.io/recipes';

  static Future<List<Recipemodel>> fetchRecipes() async {
    final uri = Uri.parse(base);

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('API error ${res.statusCode}: ${res.body}');
    }

    final data = jsonDecode(res.body);

    final results = data;

    List<Recipemodel> recipes = [];

    for (var recipeJson in results) {
      recipes.add(Recipemodel.fromJson(recipeJson));
    }

    return recipes;
  }
}
