import 'package:flutter/material.dart';
import 'package:meals_app/widgets/filter_item.dart';
import 'package:meals_app/providers/filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: Column(
        children: [
          FilterItem(
            titleText: "Gluten-free",
            subTitleText: "gluten free",
            checked: activeFilter[Filter.glutenFree]!,
            filter: Filter.glutenFree,
          ),
          FilterItem(
            titleText: "Lactose-free",
            subTitleText: "lactose free",
            checked: activeFilter[Filter.lactoseFree]!,
            filter: Filter.lactoseFree,
          ),
          FilterItem(
            titleText: "Vegetarian",
            subTitleText: "vegetarian",
            checked: activeFilter[Filter.vegetarian]!,
            filter: Filter.vegetarian,
          ),
          FilterItem(
            titleText: "Vegan",
            subTitleText: "vegan",
            checked: activeFilter[Filter.vegan]!,
            filter: Filter.vegan,
          ),
        ],
      ),
    );
  }
}
