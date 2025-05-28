import 'package:flutter/material.dart';
import 'package:label_craft/components/drawer_item.dart';
import 'package:label_craft/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Bem-vindo!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          DrawerItem(Icons.home, 'Início', AppRoutes.HOME),
          const Divider(),
          DrawerItem(Icons.label, 'Etiquetas', AppRoutes.LABEL_PAGE),
          const Divider(),
          DrawerItem(Icons.text_fields, 'Cabeçalhos', AppRoutes.HEADER_PAGE),
        ],
      ),
    );
  }
}
