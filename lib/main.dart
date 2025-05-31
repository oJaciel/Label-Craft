import 'package:flutter/material.dart';
import 'package:label_craft/models/header_provider.dart';
import 'package:label_craft/models/label_provider.dart';
import 'package:label_craft/pages/header_page.dart';
import 'package:label_craft/pages/home_page.dart';
import 'package:label_craft/pages/label_form_page.dart';
import 'package:label_craft/pages/labels_page.dart';
import 'package:label_craft/pages/pdf_generator_page.dart';
import 'package:label_craft/theme/app_theme.dart';
import 'package:label_craft/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LabelProvider()),
        ChangeNotifierProvider(create: (_) => HeaderProvider()),
      ],
      child: MaterialApp(
        title: 'Label Craft',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        themeMode: ThemeMode.system,
        routes: {
          AppRoutes.HOME: (ctx) => HomePage(),
          AppRoutes.LABEL_PAGE: (ctx) => LabelsPage(),
          AppRoutes.HEADER_PAGE: (ctx) => HeaderPage(),
          AppRoutes.LABEL_FORM: (ctx) => LabelFormPage(),
          AppRoutes.PDF_GENERATOR: (ctx) => PdfGeneratorPage(),
        },
      ),
    );
  }
}
