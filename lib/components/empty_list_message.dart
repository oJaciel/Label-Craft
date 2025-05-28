import 'package:flutter/material.dart';

class EmptyListMessage extends StatelessWidget {
  const EmptyListMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline_rounded, size: 70),
            SizedBox(height: 10),
            Text(
              'Nenhum registro encontrado!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Adicione para iniciar'),
          ],
        ),
      );
  }
}