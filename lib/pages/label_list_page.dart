import 'package:flutter/material.dart';
import 'package:label_craft/components/app_button.dart';
import 'package:label_craft/components/app_drawer.dart';
import 'package:label_craft/utils/app_routes.dart';

class LabelListPage extends StatelessWidget {
  const LabelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Etiquetas')),
      drawer: AppDrawer(),
      body: Column(
        children: [
          AppButton('Adicionar Nova Etiqueta', AppRoutes.LABEL_FORM, Icon(Icons.add))
        ],
      ),
    );
  }
}
