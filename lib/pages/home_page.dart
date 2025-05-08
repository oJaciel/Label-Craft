import 'package:flutter/material.dart';
import 'package:label_craft/components/app_drawer.dart';
import 'package:label_craft/components/label_grid.dart';
import 'package:label_craft/components/new_label_button.dart';
import 'package:label_craft/utils/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Label Craft')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            NewLabelButton('Adicionar nova etiqueta', AppRoutes.LABEL_FORM),
            SizedBox(height: 10),
            Expanded(child: LabelGrid()),
          ],
        ),
      ),
    );
  }
}
