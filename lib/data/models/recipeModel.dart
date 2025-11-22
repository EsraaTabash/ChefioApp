class Recipemodel {
  int? recipeId;
  String? recipeName;
  String? recipeImage;
  String? recipeCategory;
  //int? recipeIngredientsCount;
  double? recipeHealthScore;
  int? recipeTime;
  String? recipeDescription;
  int? recipeAggregateLikes;

  Recipemodel({
    this.recipeId,
    this.recipeName,
    this.recipeImage,
    this.recipeCategory,
    //this.recipeIngredientsCount,
    this.recipeHealthScore,
    this.recipeTime,
    this.recipeDescription,
    this.recipeAggregateLikes,
  });

  factory Recipemodel.fromJson(Map<String, dynamic> json) {
    //final dishTypes = json['dishTypes'] as List? ?? [];
    //final ingredients = json['extendedIngredients'] as List? ?? [];

    return Recipemodel(
      recipeId: json['id'] as int,
      recipeName: json['title'] as String,
      recipeImage: json['image'] as String,
      recipeCategory: json['dishTypes'] as String,
      // recipeCategory: dishTypes.isNotEmpty
      //     ? dishTypes.first.toString()
      //     : "not specified",
      //recipeIngredientsCount: ingredients.length,
      recipeHealthScore: (json['healthScore'] as num).toDouble(),
      recipeTime: json['readyInMinutes'] as int,
      recipeDescription: json['summary'] as String,
      recipeAggregateLikes: json['aggregateLikes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': recipeId ?? 0,
      'title': recipeName ?? "",
      'image': recipeImage ?? "",
      'dishTypes': recipeCategory ?? "not specified",
      //'extendedIngredients': List.filled(recipeIngredientsCount ?? 0, {}),
      'healthScore': recipeHealthScore ?? 0,
      'readyInMinutes': recipeTime ?? 0,
      'summary': recipeDescription ?? "",
      'aggregateLikes': recipeAggregateLikes ?? 0,
    };
  }
}
