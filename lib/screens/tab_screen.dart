import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/model/meals.dart';
import 'package:meals_app/providers/favorite_meal_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_screen.dart';
import 'package:meals_app/widgets/drawer_item.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/providers/filter_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int selectedPageIndex = 0;

  final List<Meal> favorites = [];

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    var selectedPageTitle = "Categories";
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    if (selectedPageIndex == 1) {
      final favoriteMeal = ref.watch(favoriteMealProvider);
      activePage = MealScreen(
        meals: favoriteMeal,
      );
      selectedPageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPageTitle),
      ),
      drawer: DrawerItem(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
