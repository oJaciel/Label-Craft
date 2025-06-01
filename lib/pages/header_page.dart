import 'package:flutter/material.dart';
import 'package:label_craft/components/app_button.dart';
import 'package:label_craft/components/app_drawer.dart';
import 'package:label_craft/components/empty_list_message.dart';
import 'package:label_craft/models/header_provider.dart';
import 'package:label_craft/utils/app_routes.dart';
import 'package:provider/provider.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final headers = Provider.of<HeaderProvider>(context).headers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Cabeçalhos'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AppButton(
              'Adicionar Novo Cabeçalho',
              AppRoutes.HEADER_FORM,
              const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            headers.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                    itemCount: headers.length,
                    itemBuilder: (ctx, i) {
                      return Column(children: [Text(''), const Divider()]);
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
