import 'package:flutter/material.dart';
import 'glass_platform.dart';

/// Glass theme data
class GlassThemeData {
  final Brightness brightness;
  final Color accentColor;
  final double blur;
  final double thickness;
  final double lightIntensity;
  final double ambientStrength;
  final double outlineIntensity;
  final double saturation;
  final Color glassColor;
  final Color surfaceColor;
  final Color onSurfaceColor;
  final Color surfaceContainerColor;
  final Color onSurfaceVariantColor;
  final Color primaryColor;
  final Color onPrimaryColor;
  final Color secondaryContainerColor;
  final Color onSecondaryContainerColor;
  final Color errorColor;
  final Color onErrorColor;
  final Color outlineColor;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  const GlassThemeData({
    required this.brightness,
    required this.accentColor,
    this.blur = 10.0,
    this.thickness = 15.0,
    this.lightIntensity = 1.5,
    this.ambientStrength = 0.1,
    this.outlineIntensity = 0.5,
    this.saturation = 1.2,
    required this.glassColor,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.surfaceContainerColor,
    required this.onSurfaceVariantColor,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.secondaryContainerColor,
    required this.onSecondaryContainerColor,
    required this.errorColor,
    required this.onErrorColor,
    required this.outlineColor,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  /// Create Glass theme from Material ColorScheme
  factory GlassThemeData.fromColorScheme(
    ColorScheme colorScheme, {
    double? blur,
    double? thickness,
    double? lightIntensity,
    double? ambientStrength,
    double? outlineIntensity,
    double? saturation,
  }) {
    final platformSettings = GlassPlatform.settings;
    final isDark = colorScheme.brightness == Brightness.dark;

    return GlassThemeData(
      brightness: colorScheme.brightness,
      accentColor: colorScheme.primary,
      blur: blur ?? platformSettings.blur,
      thickness: thickness ?? platformSettings.thickness,
      lightIntensity: lightIntensity ?? platformSettings.lightIntensity,
      ambientStrength: ambientStrength ?? platformSettings.ambientStrength,
      outlineIntensity: outlineIntensity ?? platformSettings.outlineIntensity,
      saturation: saturation ?? platformSettings.saturation,
      glassColor: isDark
          ? Colors.white.withOpacity(0.08)
          : Colors.white.withOpacity(0.7),
      surfaceColor: colorScheme.surface,
      onSurfaceColor: colorScheme.onSurface,
      surfaceContainerColor: colorScheme.surfaceContainerHighest,
      onSurfaceVariantColor: colorScheme.onSurfaceVariant,
      primaryColor: colorScheme.primary,
      onPrimaryColor: colorScheme.onPrimary,
      secondaryContainerColor: colorScheme.secondaryContainer,
      onSecondaryContainerColor: colorScheme.onSecondaryContainer,
      errorColor: colorScheme.error,
      onErrorColor: colorScheme.onError,
      outlineColor: colorScheme.outline,
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurfaceVariant,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// Create a copy with modified properties
  GlassThemeData copyWith({
    Brightness? brightness,
    Color? accentColor,
    double? blur,
    double? thickness,
    double? lightIntensity,
    double? ambientStrength,
    double? outlineIntensity,
    double? saturation,
    Color? glassColor,
    Color? surfaceColor,
    Color? onSurfaceColor,
    Color? surfaceContainerColor,
    Color? onSurfaceVariantColor,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? secondaryContainerColor,
    Color? onSecondaryContainerColor,
    Color? errorColor,
    Color? onErrorColor,
    Color? outlineColor,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return GlassThemeData(
      brightness: brightness ?? this.brightness,
      accentColor: accentColor ?? this.accentColor,
      blur: blur ?? this.blur,
      thickness: thickness ?? this.thickness,
      lightIntensity: lightIntensity ?? this.lightIntensity,
      ambientStrength: ambientStrength ?? this.ambientStrength,
      outlineIntensity: outlineIntensity ?? this.outlineIntensity,
      saturation: saturation ?? this.saturation,
      glassColor: glassColor ?? this.glassColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      onSurfaceColor: onSurfaceColor ?? this.onSurfaceColor,
      surfaceContainerColor: surfaceContainerColor ?? this.surfaceContainerColor,
      onSurfaceVariantColor: onSurfaceVariantColor ?? this.onSurfaceVariantColor,
      primaryColor: primaryColor ?? this.primaryColor,
      onPrimaryColor: onPrimaryColor ?? this.onPrimaryColor,
      secondaryContainerColor: secondaryContainerColor ?? this.secondaryContainerColor,
      onSecondaryContainerColor: onSecondaryContainerColor ?? this.onSecondaryContainerColor,
      errorColor: errorColor ?? this.errorColor,
      onErrorColor: onErrorColor ?? this.onErrorColor,
      outlineColor: outlineColor ?? this.outlineColor,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }
}

/// Glass theme provider (InheritedWidget)
class GlassThemeProvider extends InheritedWidget {
  final GlassThemeData data;

  const GlassThemeProvider({
    super.key,
    required this.data,
    required super.child,
  });

  static GlassThemeData of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<GlassThemeProvider>();
    assert(provider != null, 'No GlassThemeProvider found in context');
    return provider!.data;
  }

  static GlassThemeData? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GlassThemeProvider>()
        ?.data;
  }

  @override
  bool updateShouldNotify(GlassThemeProvider oldWidget) {
    return data != oldWidget.data;
  }
}

/// Extension to easily access Glass theme from BuildContext
extension GlassThemeExtension on BuildContext {
  GlassThemeData get glassTheme => GlassThemeProvider.of(this);
  GlassThemeData? get glassThemeOrNull => GlassThemeProvider.maybeOf(this);
}
