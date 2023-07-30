import 'package:flutter/material.dart';
import 'package:meals_app/model/meals.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_screen.dart';
import 'package:meals_app/widgets/drawer_item.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int selectedPageIndex = 0;
  var selectedPageTitle = "Categories";
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  final List<Meal> favorites = [];
  void _toggleMealFavoritesStatus(Meal meal) {
    final isExisting = favorites.contains(meal);
    if (isExisting) {
      setState(() {
        favorites.remove(meal);
      });
      showSnackBar('Meal is no longer a favorite');
    } else {
      setState(() {
        favorites.add(meal);
      });
      showSnackBar('Marked as favorite');
    }
  }

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorites: _toggleMealFavoritesStatus,
    );

    if (selectedPageIndex == 1) {
      activePage = MealScreen(
        meals: favorites,
        onToggleFavorites: _toggleMealFavoritesStatus,
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
