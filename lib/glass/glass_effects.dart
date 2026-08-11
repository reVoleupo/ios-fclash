import 'dart:ui';
import 'package:flutter/material.dart';
import 'glass_platform.dart';
import 'glass_theme.dart';

/// Liquid Glass container with blur and transparency effects
class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final double? blur;
  final Color? tintColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final BoxBorder? border;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.blur,
    this.tintColor,
    this.borderRadius,
    this.padding,
    this.border,
    this.shadows,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return child;
    }

    final glassTheme = GlassThemeDataProvider.of(context);
    final platformSettings = GlassPlatform.settings;
    final effectiveBlur = blur ?? glassTheme?.blur ?? platformSettings.blur;
    final effectiveBorderRadius =
        borderRadius ?? platformSettings.borderRadius;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveTintColor = tintColor ??
        (isDark
            ? Colors.white.withOpacity(0.08)
            : Colors.white.withOpacity(0.7));

    return ClipRRect(
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
        child: Container(
          decoration: BoxDecoration(
            color: effectiveTintColor,
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            border: border ??
                Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.15)
                      : Colors.white.withOpacity(0.5),
                  width: 0.5,
                ),
            boxShadow: shadows ??
                [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
            gradient: gradient,
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

/// Liquid Glass layer that wraps multiple glass elements
class LiquidGlassLayer extends StatelessWidget {
  final Widget child;
  final double? blur;
  final Color? tintColor;

  const LiquidGlassLayer({
    super.key,
    required this.child,
    this.blur,
    this.tintColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return child;
    }

    return child;
  }
}

/// Glass-themed text widget
class GlassText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const GlassText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Glass-themed icon widget
class GlassIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const GlassIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}

/// Glass-themed divider
class GlassDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const GlassDivider({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Divider(
      height: height ?? 1,
      thickness: thickness ?? 0.5,
      indent: indent,
      endIndent: endIndent,
      color: color ??
          (isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1)),
    );
  }
}

/// Helper class for accessing GlassThemeData via InheritedWidget
class GlassThemeDataProvider extends InheritedWidget {
  final GlassThemeData? data;

  const GlassThemeDataProvider({
    super.key,
    this.data,
    required super.child,
  });

  static GlassThemeData? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GlassThemeDataProvider>()
        ?.data;
  }

  @override
  bool updateShouldNotify(GlassThemeDataProvider oldWidget) {
    return data != oldWidget.data;
  }
}
