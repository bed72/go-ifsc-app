import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_ifsc/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme(this.context);

  final BuildContext context;

  ThemeData get defaultTheme => ThemeData(
        primaryColor: AppColors.primary,
        accentColor: AppColors.accent,

        brightness: Brightness.dark,
        primarySwatch: AppColors.primary,
        // Define a font escolhida no app como um todo
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  ThemeData get defaultThemeDark => ThemeData(
        primaryColor: AppColors.primary,
        accentColor: AppColors.accent,
        brightness: Brightness.dark,
        primarySwatch: AppColors.primary,
      );
}
