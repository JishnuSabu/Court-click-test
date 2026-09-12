import 'package:flutter/material.dart';

class CmHorizontalListViewWidget<T> extends StatelessWidget {
  final List<dynamic> items;
  final double height;
  final EdgeInsetsGeometry padding;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  const CmHorizontalListViewWidget({
    super.key,
    required this.items,
    required this.height,
    required this.itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return itemBuilder(context, items[index] as T, index);
        },
      ),
    );
  }
}
