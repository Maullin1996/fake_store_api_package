import 'package:flutter/material.dart';

/// This file defines a set of color constants used throughout the example application.
abstract class AppColors {
  /// The primary color of the application.
  static const Color primary = Color(0xFF1565C0);

  /// A darker variant of the primary color.
  static const Color primaryVariant = Color(0xFF0D47A1);

  /// The secondary color of the application.
  static const Color secondary = Color(0xFFFFC107);

  /// A darker variant of the secondary color.
  static const Color secondaryVariant = Color(0xFFFFA000);

  /// The background color used for the app's main screens.
  static const Color background = Color(0xFFF5F5F5);

  /// The surface color used for cards, dialogs, and other elevated surfaces.
  static const Color surface = Color(0xFFFFFFFF);

  /// The color used to indicate errors in the application.
  static const Color error = Color(0xFFD32F2F);

  /// The color used for text and icons on primary-colored backgrounds.
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// The color used for text and icons on secondary-colored backgrounds.
  static const Color onSecondary = Color(0xFF212121);

  /// The color used for text and icons on background-colored surfaces.
  static const Color onBackground = Color(0xFF212121);

  /// The color used for text and icons on surface-colored surfaces.
  static const Color onSurface = Color(0xFF212121);

  /// The color used for text and icons on error-colored surfaces.
  static const Color onError = Color(0xFFFFFFFF);

  /// A semi-transparent color used for background text or subtle UI elements.
  static const Color backGroundText = Color.fromRGBO(117, 117, 117, 0.788);
}
