import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'viewmodels/meal_bloc.dart';
import 'views/home_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => MealBloc()..add(FetchMealsEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
