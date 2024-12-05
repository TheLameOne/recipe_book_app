import 'package:flutter/material.dart';
import 'package:recipe_book_app/models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  final Widget? trailing; // Added trailing widget for custom actions

  const MealCard({
    required this.meal,
    required this.onTap,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(meal.thumbnail,
            width: 50, height: 50, fit: BoxFit.cover),
        title: Text(meal.mealName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(meal.category),
        trailing: trailing, // Trailing widget for favorite button
        onTap: onTap,
      ),
    );
  }
}
