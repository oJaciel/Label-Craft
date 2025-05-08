import 'package:flutter/material.dart';

class NewLabelButton extends StatelessWidget {
  const NewLabelButton(this.text, this.route, {super.key});

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: TextButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
        label: Text('Adicionar nova etiqueta'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
