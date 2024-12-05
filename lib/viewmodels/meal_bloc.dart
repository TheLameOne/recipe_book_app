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

abstract class MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> meals;
  final List<Meal> favorites;

  MealLoaded({required this.meals, required this.favorites});
}

class MealError extends MealState {
  final String error;
  MealError(this.error);
}

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository _mealRepository = MealRepository();
  final List<Meal> _favorites = [];

  MealBloc() : super(MealLoading()) {
    on<FetchMealsEvent>((event, emit) async {
      emit(MealLoading());
      try {
        // Fetch 10 recipes
        final List<Meal> meals = [];
        for (int i = 0; i < 10; i++) {
          final fetchedMeals = await _mealRepository.fetchMeals();
          meals.addAll(fetchedMeals);
        }
        emit(MealLoaded(meals: meals, favorites: _favorites));
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
            meals: (state as MealLoaded).meals, favorites: _favorites));
      }
    });

    on<AddFavoriteEvent>((event, emit) {
      _favorites.add(event.meal);
      emit(MealLoaded(
          meals: (state as MealLoaded).meals, favorites: _favorites));
    });

    on<RemoveFavoriteEvent>((event, emit) {
      _favorites.remove(event.meal);
      emit(MealLoaded(
          meals: (state as MealLoaded).meals, favorites: _favorites));
    });
  }
}
