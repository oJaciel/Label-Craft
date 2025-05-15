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
    return ListTile(
      title: Text(label.name),
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
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: Text('Exclusão de Item'),
                        content: Text('Deseja remover o item?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                            child: Text('Não'),
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
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                );
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
