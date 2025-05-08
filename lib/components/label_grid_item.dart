import 'package:flutter/material.dart';

class LabelGridItem extends StatelessWidget {
  const LabelGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GridTile(child: Center(child: Text('Etiqueta')));
  }
}
