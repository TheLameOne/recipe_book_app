class Meal {
  final String mealID;
  final String mealName;
  final String category;
  final String instructions;
  final String thumbnail;

  Meal({
    required this.mealID,
    required this.mealName,
    required this.category,
    required this.instructions,
    required this.thumbnail,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mealID: json['idMeal'],
      mealName: json['strMeal'],
      category: json['strCategory'],
      instructions: json['strInstructions'],
      thumbnail: json['strMealThumb'],
    );
  }
}
