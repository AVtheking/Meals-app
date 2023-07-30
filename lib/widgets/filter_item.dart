import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  const FilterItem(
      {super.key,
      required this.titleText,
      required this.subTitleText,
      required this.checked,
      required this.onChanged});
  final String titleText;
  final String subTitleText;
  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: widget.checked,
      onChanged: (isChecked) {
        setState(() {
          widget.onChanged(isChecked);
        });
      },
      title: Text(
        widget.titleText,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        "Only include ${widget.subTitleText} meals ",
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
