import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/meal.dart';
import '../repositories/meal_repository.dart';

abstract class MealEvent {}

class FetchMealsEvent extends MealEvent {}

class ToggleFavoriteEvent extends MealEvent {
  final Meal meal;
  ToggleFavoriteEvent(this.meal);
}

class AddFavoriteEvent extends MealEvent {
  final Meal meal;
  AddFavoriteEvent(this.meal);
}

class RemoveFavoriteEvent extends MealEvent {
  final Meal meal;
  RemoveFavoriteEvent(this.meal);
}

class SearchMealsEvent extends MealEvent {
  final String query;
  SearchMealsEvent(this.query);
}

abstract class MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> meals;
  final List<Meal> filteredMeals;
  final List<Meal> favorites;

  MealLoaded({
    required this.meals,
    required this.filteredMeals,
    required this.favorites,
  });
}

class MealError extends MealState {
  final String error;
  MealError(this.error);
}

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository _mealRepository = MealRepository();
  final List<Meal> _favorites = [];
  List<Meal> _allMeals = [];

  MealBloc() : super(MealLoading()) {
    on<FetchMealsEvent>((event, emit) async {
      emit(MealLoading());
      try {
        final List<Meal> meals = [];
        for (int i = 0; i < 10; i++) {
          final fetchedMeals = await _mealRepository.fetchMeals();
          meals.addAll(fetchedMeals);
        }
        _allMeals = meals;
        emit(MealLoaded(
            meals: meals, filteredMeals: meals, favorites: _favorites));
      } catch (e) {
        emit(MealError(e.toString()));
      }
    });

    on<ToggleFavoriteEvent>((event, emit) {
      if (_favorites.contains(event.meal)) {
        _favorites.remove(event.meal);
      } else {
        _favorites.add(event.meal);
      }

      if (state is MealLoaded) {
        emit(MealLoaded(
          meals: _allMeals,
          filteredMeals: (state as MealLoaded).filteredMeals,
          favorites: _favorites,
        ));
      }
    });

    on<AddFavoriteEvent>((event, emit) {
      _favorites.add(event.meal);
      if (state is MealLoaded) {
        emit(MealLoaded(
          meals: _allMeals,
          filteredMeals: (state as MealLoaded).filteredMeals,
          favorites: _favorites,
        ));
      }
    });
    on<RemoveFavoriteEvent>((event, emit) {
      _favorites.remove(event.meal);
      if (state is MealLoaded) {
        emit(MealLoaded(
          meals: _allMeals,
          filteredMeals: (state as MealLoaded).filteredMeals,
          favorites: _favorites,
        ));
      }
    });

    on<SearchMealsEvent>((event, emit) {
      if (state is MealLoaded) {
        final query = event.query.toLowerCase();
        final filteredMeals = _allMeals
            .where((meal) => meal.mealName.toLowerCase().contains(query))
            .toList();

        emit(MealLoaded(
          meals: _allMeals,
          filteredMeals: filteredMeals,
          favorites: _favorites,
        ));
      }
    });
  }
}
