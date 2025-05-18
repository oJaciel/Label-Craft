import 'package:flutter/material.dart';
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
          ListTile(
            leading: Icon(
              Icons.label,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Etiquetas',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.create,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Gerenciar Etiquetas',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.LABEL_LIST);
            },
          ),
        ],
      ),
    );
  }
}
