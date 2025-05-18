import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 1, 102, 153); // Azul
  static const Color secondaryColor = Color(0xFFF57C00); // Laranja
  static const Color accentColor = Color(0xFF3C4D5E); // Azul petróleo
  static const Color backgroundColor = Color(0xFFF4F6F7); // Fundo claro
  static const Color greyLight = Color(0xFFBDBDBD); // Cinza claro
  static const Color grey = Color(0xFF9E9E9E); // Cinza médio
  static const Color textColor = Color(0xFF3C4D5E); // Igual ao azul petróleo

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,

      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),

      buttonTheme: ButtonThemeData(
        buttonColor: secondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        labelStyle: TextStyle(color: accentColor, fontWeight: FontWeight.w600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: grey, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return greyLight;
          return grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primaryColor;
          return greyLight;
        }),
      ),
      dividerTheme: DividerThemeData(
        color: primaryColor
      )
    );
  }
}
