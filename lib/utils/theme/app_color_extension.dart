import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {

  AppColorsExtension({
    required this.onPrimary,
    required this.background,
    this.onSecondary,
    this.error,
    this.onError,
    this.onBackground,
    this.surface,
    this.onSurface,
  });

  final Color onPrimary;
  final Color background;
  final Color? onSecondary;
  final Color? error;
  final Color? onError;
  final Color? onBackground;
  final Color? surface;
  final Color? onSurface;



  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? background,
  }) {
    return AppColorsExtension(
      onPrimary: primary ?? onPrimary,
      background: background ?? this.background,

    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
      covariant ThemeExtension<AppColorsExtension>? other,
      double t,
      ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      background: Color.lerp(background, other.background, t)!,
    );
  }
}