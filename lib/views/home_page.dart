import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/meal_bloc.dart';
import 'meal_details_page.dart';
import 'favorites_page.dart';
import 'widgets/meal_card.dart';
import 'widgets/error_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              searchController.clear();
              context.read<MealBloc>().add(FetchMealsEvent());
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesPage()),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                context.read<MealBloc>().add(SearchMealsEvent(query));
              },
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<MealBloc, MealState>(
        builder: (context, state) {
          if (state is MealLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MealLoaded) {
            return ListView.builder(
              itemCount: state.filteredMeals.length,
              itemBuilder: (context, index) {
                final meal = state.filteredMeals[index];
                final isFavorite = state.favorites.contains(meal);

                return MealCard(
                  meal: meal,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MealDetailsPage(meal: meal)),
                  ),
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
                );
              },
            );
          } else if (state is MealError) {
            return AppErrorWidget(message: state.error);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
