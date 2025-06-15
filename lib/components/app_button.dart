import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(this.text, this.icon, {super.key, this.route = '', this.function});

  final String text;
  final String? route;
  final VoidCallback? function;
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
          if (function != null) {
            function!();
          } else if (route != null && route!.isNotEmpty) {
            Navigator.of(context).pushNamed(route!);
          } else {
            // Nenhuma ação definida
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nenhuma ação configurada')),
            );
          }
        },
        label: Text(text),
        icon: icon,
      ),
    );
  }
}
