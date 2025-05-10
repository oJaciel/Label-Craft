import 'package:flutter/material.dart';
import 'package:label_craft/components/label_grid_item.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/label_provider.dart';
import 'package:provider/provider.dart';

class LabelGrid extends StatelessWidget {
  const LabelGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LabelProvider>(context);

    final List<Label> loadedLabels = provider.labels;

    return GridView.builder(
      itemCount: loadedLabels.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => LabelGridItem(loadedLabels[i]),
    );
  }
}
