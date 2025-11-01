class Recipemodel {
  String? recipeName;
  String? recipeImage;
  String? recipeCategory;
  int? recipeIngredientsCount;
  int? recipeTime;
  String? recipeDescription;

  Recipemodel({
    this.recipeName,
    this.recipeImage,
    this.recipeCategory,
    this.recipeIngredientsCount,
    this.recipeTime,
    this.recipeDescription,
  });

  factory Recipemodel.fromJson(Map<String, dynamic> json) {
    final dishTypes = json['dishTypes'] as List<dynamic>? ?? [];
    final ingredients = json['extendedIngredients'] as List<dynamic>? ?? [];

    return Recipemodel(
      recipeName: json['title'] ?? "",
      recipeImage: json['image'] ?? "",
      recipeCategory: dishTypes.isNotEmpty
          ? dishTypes.first.toString()
          : "not specified",
      recipeIngredientsCount: ingredients.length,
      recipeTime: json['readyInMinutes'],
      recipeDescription: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': recipeName ?? "",
      'image': recipeImage ?? "",
      'dishTypes': [recipeCategory ?? "not specified"],
      'extendedIngredients': recipeIngredientsCount ?? 0,
      'readyInMinutes': recipeTime ?? 0,
      'summary': recipeDescription ?? "",
    };
  }
}
