import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailsPage extends StatelessWidget {
  final Meal meal;

  const MealDetailsPage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.mealName)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.network(meal.thumbnail,
                      height: 200, fit: BoxFit.cover)),
              const SizedBox(height: 16),
              Text(meal.category,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text(meal.instructions, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
