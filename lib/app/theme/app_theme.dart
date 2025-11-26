import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => _buildTheme(_lightScheme);
  static ThemeData get dark => _buildTheme(_darkScheme);

  static ThemeData _buildTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: scheme.primary),
      ),
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant),
    );
  }

  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF4F46E5),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFE0E7FF),
    onPrimaryContainer: Color(0xFF1E1B4B),
    secondary: Color(0xFF6366F1),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFF1F5F9),
    onSecondaryContainer: Color(0xFF1F2933),
    tertiary: Color(0xFF94A3B8),
    onTertiary: Colors.white,
    error: Color(0xFFB3261E),
    onError: Colors.white,
    errorContainer: Color(0xFFF9DEDC),
    onErrorContainer: Color(0xFF410E0B),
    background: Colors.white,
    onBackground: Color(0xFF111827),
    surface: Colors.white,
    onSurface: Color(0xFF111827),
    surfaceVariant: Color(0xFFF4F6FB),
    onSurfaceVariant: Color(0xFF4B5563),
    outline: Color(0xFFCBD5E1),
    outlineVariant: Color(0xFFE2E8F0),
    shadow: Colors.black12,
    scrim: Colors.black54,
    inverseSurface: Color(0xFF1F2933),
    inversePrimary: Color(0xFFC7D2FE),
  );

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFC7D2FE),
    onPrimary: Color(0xFF1C1D3B),
    primaryContainer: Color(0xFF383D8A),
    onPrimaryContainer: Color(0xFFE0E7FF),
    secondary: Color(0xFFCBD5F5),
    onSecondary: Color(0xFF1A1C2E),
    secondaryContainer: Color(0xFF2A2F45),
    onSecondaryContainer: Color(0xFFF1F5F9),
    tertiary: Color(0xFF94A3B8),
    onTertiary: Color(0xFF0F172A),
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
    background: Color(0xFF0F111A),
    onBackground: Color(0xFFE5E7EB),
    surface: Color(0xFF11131F),
    onSurface: Color(0xFFE5E7EB),
    surfaceVariant: Color(0xFF1D2030),
    onSurfaceVariant: Color(0xFF9CA3AF),
    outline: Color(0xFF4B5563),
    outlineVariant: Color(0xFF374151),
    shadow: Colors.black,
    scrim: Colors.black87,
    inverseSurface: Color(0xFFE5E7EB),
    inversePrimary: Color(0xFF4F46E5),
  );
}
