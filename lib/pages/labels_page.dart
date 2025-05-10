import 'package:flutter/material.dart';
import 'package:label_craft/components/app_button.dart';
import 'package:label_craft/components/app_drawer.dart';
import 'package:label_craft/components/labels_page_item.dart';
import 'package:label_craft/models/label_provider.dart';
import 'package:label_craft/utils/app_routes.dart';
import 'package:provider/provider.dart';

class LabelsPage extends StatelessWidget {
  const LabelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final labels = Provider.of<LabelProvider>(context).labels;

    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Etiquetas')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppButton(
              'Adicionar Nova Etiqueta',
              AppRoutes.LABEL_FORM,
              Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: labels.length,
                itemBuilder: (ctx, i) {
                  return Column(
                    children: [LabelsPageItem(labels[i]), const Divider()],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
