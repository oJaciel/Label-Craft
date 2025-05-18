import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(this.text, this.route, this.icon, {super.key});

  final String text;
  final String route;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          iconColor: Colors.white
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
        label: Text(text),
        icon: icon,
      ),
    );
  }
}
