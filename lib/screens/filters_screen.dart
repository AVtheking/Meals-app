import 'package:flutter/material.dart';
import 'package:meals_app/widgets/filter_item.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<String, bool> _filterStates = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  // Callback function to update the state of the switches
  void _updateFilterState(String filterKey, bool value) {
    setState(() {
      _filterStates[filterKey] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _filterStates['gluten'],
            Filter.lactoseFree: _filterStates['lactose'],
            Filter.vegetarian: _filterStates['vegetarian'],
            Filter.vegan: _filterStates['vegan'],
          });
          return false;
        },
        child: Column(
          children: [
            FilterItem(
              titleText: "Gluten-free",
              subTitleText: "gluten free",
              checked: _filterStates['gluten']!,
              onChanged: (isChecked) => _updateFilterState('gluten', isChecked),
            ),
            FilterItem(
              titleText: "Lactose-free",
              subTitleText: "lactose free",
              checked: _filterStates['lactose']!,
              onChanged: (isChecked) =>
                  _updateFilterState('lactose', isChecked),
            ),
            FilterItem(
              titleText: "Vegetarian",
              subTitleText: "vegetarian",
              checked: _filterStates['vegetarian']!,
              onChanged: (isChecked) =>
                  _updateFilterState('vegetarian', isChecked),
            ),
            FilterItem(
              titleText: "Vegan",
              subTitleText: "vegan",
              checked: _filterStates['vegan']!,
              onChanged: (isChecked) => _updateFilterState('vegan', isChecked),
            ),
          ],
        ),
      ),
    );
  }
}
