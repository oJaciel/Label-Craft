import 'package:flutter/material.dart';
import 'package:label_craft/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: Text('Bem vindo!'), automaticallyImplyLeading: false),
          Divider(),
          ListTile(
            leading: Icon(Icons.label),
            title: Text('Etiquetas'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
        ],
      ),
    );
  }
}
