import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:label_craft/components/empty_list_message.dart';
import 'package:label_craft/components/label_grid_item.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/label_provider.dart';
import 'package:provider/provider.dart';

class LabelGrid extends StatelessWidget {
  const LabelGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double calculateAspectRatio() {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        return 3 / 3;
      } else if (kIsWeb ||
          (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
        return 3 / 2;
      } else {
        return 3 / 3;
      }
    }

    final provider = Provider.of<LabelProvider>(context);

    final List<Label> loadedLabels = provider.labels;

    if (loadedLabels.isNotEmpty) {
      return GridView.builder(
        itemCount: loadedLabels.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: calculateAspectRatio(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => LabelGridItem(loadedLabels[i]),
      );
    } else {
      return EmptyListMessage();
    }
  }
}
