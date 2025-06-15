import 'package:flutter/material.dart';
import 'package:label_craft/components/app_button.dart';
import 'package:label_craft/components/app_drawer.dart';
import 'package:label_craft/components/label_grid.dart';
import 'package:label_craft/models/header_provider.dart';
import 'package:label_craft/models/label_provider.dart';
import 'package:label_craft/utils/app_routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    try {
      Provider.of<LabelProvider>(context, listen: false).loadLabels();
      Provider.of<HeaderProvider>(context, listen: false).loadHeaders();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Label Craft')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'O que vamos fazer hoje?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              AppButton(
                'Criar nova etiqueta',
                route: AppRoutes.LABEL_FORM,
                Icon(Icons.add),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      'Gerenciar Etiquetas',
                      route: AppRoutes.LABEL_PAGE,
                      Icon(Icons.label),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      'Gerenciar Cabeçalhos',
                      route: AppRoutes.HEADER_PAGE,
                      Icon(Icons.text_fields),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                elevation: 2,
                margin: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.label_outline),
                        title: Text(
                          'Suas Etiquetas',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Text(
                          'Clique em uma etiqueta para imprimi-lá',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ),
                      SizedBox(height: 5),
                      LabelGrid(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
