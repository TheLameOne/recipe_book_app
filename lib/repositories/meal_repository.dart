import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealRepository {
  Future<List<Meal>> fetchMeals() async {
    final response = await http
        .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final meals =
          (data['meals'] as List).map((meal) => Meal.fromJson(meal)).toList();
      return meals;
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
