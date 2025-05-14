import 'package:flutter/material.dart';
import 'package:label_craft/components/app_button.dart';
import 'package:label_craft/components/app_drawer.dart';
import 'package:label_craft/components/label_grid.dart';
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
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Label Craft')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppButton('Gerenciar Etiquetas', AppRoutes.LABEL_LIST, Icon(Icons.create)),
            SizedBox(height: 10),
            Expanded(child: LabelGrid()),
          ],
        ),
      ),
    );
  }
}
