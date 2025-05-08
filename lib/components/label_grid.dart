import 'package:flutter/material.dart';
import 'package:label_craft/components/label_grid_item.dart';

class LabelGrid extends StatelessWidget {
  const LabelGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10, // Substitua com a quantidade real de itens
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => Card(
        child: LabelGridItem(),
      ),
    );
  }
}
