import 'package:flutter/material.dart';
import 'package:label_craft/components/app_button.dart';
import 'package:label_craft/components/app_drawer.dart';
import 'package:label_craft/components/empty_list_message.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final header_data = [];

    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Cabeçalhos')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppButton(
              'Adicionar Novo Cabeçalho',
              '',
              const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            header_data.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                    itemCount: header_data.length,
                    itemBuilder: (ctx, i) {
                      return Column(
                        children: [Text('Cabeçalho'), const Divider()],
                      );
                    },
                  ),
                )
                : const EmptyListMessage(),
          ],
        ),
      ),
    );
  }
}
