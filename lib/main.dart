import 'package:flutter/material.dart';
import 'package:label_craft/models/label_provider.dart';
import 'package:label_craft/pages/home_page.dart';
import 'package:label_craft/pages/label_form_page.dart';
import 'package:label_craft/pages/labels_page.dart';
import 'package:label_craft/pages/pdf_generator_page.dart';
import 'package:label_craft/theme/app_theme.dart';
import 'package:label_craft/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LabelProvider())],
      child: MaterialApp(
        title: 'Label Craft',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        themeMode: ThemeMode.system,
        routes: {
          AppRoutes.HOME: (ctx) => HomePage(),
          AppRoutes.LABEL_LIST: (ctx) => LabelsPage(),
          AppRoutes.LABEL_FORM: (ctx) => LabelFormPage(),
          AppRoutes.PDF_GENERATOR: (ctx) => PdfGeneratorPage(),
        },
      ),
    );
  }
}
