import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/category.dart';
import 'package:meals_app/model/meals.dart';
import 'package:meals_app/screens/meal_screen.dart';
import 'package:meals_app/widgets/category_grid.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorites,
      required this.availableMeals});

  final void Function(Meal meal) onToggleFavorites;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealScreen(
            meals: filteredMeals,
            title: category.title,
            onToggleFavorites: onToggleFavorites),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
      children: [
        // availableCategories.map((category))=>CategoryGrid(category:category)
        for (final category in availableCategories)
          CategoryGrid(
            category: category,
            selectedCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
