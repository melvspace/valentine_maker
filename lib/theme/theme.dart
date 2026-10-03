import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'theme.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onBuildContextProps)
class AppColors extends ThemeExtension<AppColors> with _$AppColorsTailorMixin {
  const AppColors({
    this.background = const Color(0xFFFA9FED),
    this.text = Colors.white,
    this.blue = const Color(0xFF347AFE),
    this.green = const Color(0xFF00DEB7),
    this.pink = const Color(0xFFFE82EA),
    this.red = const Color(0xFFFF414D),
    this.violet = const Color(0xFFCA8FFF),
    this.cyan = const Color(0xFF57F5FF),
    this.yellow = const Color(0xFFFFE264),
    this.white = Colors.white,
    this.black = Colors.black,
  });

  static const light = AppColors();

  @override
  final Color background;
  @override
  final Color text;
  @override
  final Color blue;
  @override
  final Color green;
  @override
  final Color pink;
  @override
  final Color red;
  @override
  final Color violet;
  @override
  final Color cyan;
  @override
  final Color yellow;
  @override
  final Color white;
  @override
  final Color black;
}

@TailorMixin(themeGetter: ThemeGetter.onBuildContextProps)
class AppStyles extends ThemeExtension<AppStyles> with _$AppStylesTailorMixin {
  const AppStyles({required this.h1, required this.button});

  static const _kFontFamily = GoogleFonts.fredoka;

  static final core = AppStyles(
    h1: _kFontFamily(fontSize: 50, height: 62 / 50, fontWeight: FontWeight.w600),
    button: _kFontFamily(fontSize: 20, height: 24 / 20, fontWeight: FontWeight.w600),
  );

  @override
  final TextStyle h1;
  @override
  final TextStyle button;
}

final kLightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.light.background,
  ),
  textTheme: ThemeData().textTheme.apply(
        bodyColor: AppColors.light.text,
        displayColor: AppColors.light.text,
      ),
  extensions: [
    AppColors.light,
    AppStyles.core,
  ],
  useMaterial3: true,
);

final kDarkTheme = ThemeData.dark(
  useMaterial3: true,
).copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.light.background,
  ),
  textTheme: ThemeData().textTheme.apply(
        bodyColor: AppColors.light.text,
        displayColor: AppColors.light.text,
      ),
  extensions: [
    AppColors.light,
    AppStyles.core,
  ],
);
