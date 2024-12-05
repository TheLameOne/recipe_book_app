# Recipe Book App
---

## **Features**

- **Recipe Listing:**  
  Browse through a list of recipes fetched dynamically from the repository.

- **Search Functionality:**  
  Search for recipes using a search bar for real-time filtering.

- **Favorites Management:**  
  Mark recipes as favorites and view them on a dedicated Favorites page.

- **Refresh Recipes:**  
  Reload the list of recipes with a refresh button.

- **Recipe Details:**  
  View detailed information about a recipe by selecting it from the list.

- **State Management:**  
  Use **Flutter Bloc** to  manage application state.

---

## **Screens**

1. **Home Page**
   - Displays a list of 10 random recipes.
   - Includes a search bar, refresh button, and a shortcut to the Favorites page.
   - Provides the ability to add/remove recipes from favorites.

2. **Favorites Page**
   - A dedicated page displaying all favorite recipes.
   - Manage favorites with a simple toggle.

3. **Recipe Details Page**
   - Displays detailed information about the selected recipe.

---
## Video Demo
[Youtube Video Link](https://youtu.be/NhATHDWXidE)

## *Folder Structure*
```
lib/
├── models/
│   └── meals.dart
├── repositories/
│   └── meal_repository.dart
├── viewmodels/
│   └── meal_bloc.dart
├── views/
│   ├── widgets/
│   │   ├── error_widget.dart
│   │   └── meal_card.dart
│   ├── favourites_page.dart
│   ├── home_page.dart
│   └── meal_details_page.dart
└── main.dart
```

## *Architecture*
MVVM Architecture


