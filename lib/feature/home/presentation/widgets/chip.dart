import 'package:flutter/material.dart';

class GridChipSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final void Function(String label)? onTap;
  final int chipsPerRow;

  const GridChipSection({
    super.key,
    required this.title,
    required this.items,
    this.onTap,
    this.chipsPerRow = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rows = <Widget>[];

    for (int i = 0; i < items.length; i += chipsPerRow) {
      final rowItems = items.sublist(i, i + chipsPerRow > items.length ? items.length : i + chipsPerRow);

      rows.add(
        Row(
          children: rowItems.map((item) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () => onTap?.call(item),
                    borderRadius: BorderRadius.circular(16),
                    splashColor: Colors.blue.shade100,
                    highlightColor: Colors.blue.shade100, // pressed color
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      alignment: Alignment.center,
                      child: Text(
                        item,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...rows,
      ],
    );
  }
}
