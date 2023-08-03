import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filter_provider.dart';

class FilterItem extends ConsumerWidget {
  const FilterItem(
      {super.key,
      required this.titleText,
      required this.subTitleText,
      required this.checked,
      required this.filter});
  final String titleText;
  final String subTitleText;
  final bool checked;
  final Filter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      value: checked,
      onChanged: (isChecked) {
        ref.read(filterProvider.notifier).setFilter(filter, isChecked);
      },
      title: Text(
        titleText,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        "Only include $subTitleText meals ",
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
