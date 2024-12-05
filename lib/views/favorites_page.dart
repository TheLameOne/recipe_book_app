import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/meal_bloc.dart';
import 'meal_details_page.dart';
import 'widgets/meal_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Recipes')),
      body: BlocBuilder<MealBloc, MealState>(
        builder: (context, state) {
          if (state is MealLoaded && state.favorites.isNotEmpty) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final meal = state.favorites[index];
                final isFavorite = state.favorites.contains(meal);
                return MealCard(
                  meal: meal,
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        context.read<MealBloc>().add(RemoveFavoriteEvent(meal));
                      } else {
                        context.read<MealBloc>().add(AddFavoriteEvent(meal));
                      }
                    },
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MealDetailsPage(meal: meal)),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No favorite recipes yet.'));
          }
        },
      ),
    );
  }
}
