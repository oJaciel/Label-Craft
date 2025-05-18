import 'package:flutter/material.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/label_provider.dart';
import 'package:label_craft/utils/app_routes.dart';
import 'package:provider/provider.dart';

class LabelsPageItem extends StatelessWidget {
  const LabelsPageItem(this.label, {super.key});

  final Label label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      title: Text(label.name, style: theme.textTheme.titleMedium),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.LABEL_FORM, arguments: label);
              },
              icon: Icon(Icons.edit, color: colorScheme.primary),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text('Exclusão de Item'),
                        content: const Text('Deseja remover o item?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                            child: const Text('Não'),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<LabelProvider>(
                                context,
                                listen: false,
                              ).removeLabel(label);
                              Navigator.of(context).pop(true);
                            },
                            child: Text(
                              'Sim',
                              style: TextStyle(color: colorScheme.error),
                            ),
                          ),
                        ],
                      ),
                );
              },
              icon: Icon(Icons.delete, color: colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
