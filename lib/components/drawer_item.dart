import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(this.icon, this.text, this.route, {super.key});

  final IconData icon;
  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(route);
      },
    );
  }
}
