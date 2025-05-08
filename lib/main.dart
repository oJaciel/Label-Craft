import 'package:flutter/material.dart';
import 'package:label_craft/pages/home_page.dart';
import 'package:label_craft/pages/label_form_page.dart';
import 'package:label_craft/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Label Craft',
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.HOME: (ctx) => HomePage(),
        AppRoutes.LABEL_FORM: (ctx) => LabelFormPage(),
      }

    );
  }
}