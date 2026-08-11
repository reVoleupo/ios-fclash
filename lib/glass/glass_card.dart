import 'package:flutter/material.dart';
import 'glass_effects.dart';
import 'glass_platform.dart';

/// Glass-themed card that replaces Material Card
class GlassCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final bool isError;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<BoxShadow>? shadows;

  const GlassCard({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.isSelected = false,
    this.isError = false,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      // Fallback to Material design
      return _buildMaterialCard(context);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final effectiveBorderRadius = borderRadius ?? 14.0;

    Color effectiveBackgroundColor;
    Color effectiveBorderColor;

    if (isError) {
      effectiveBackgroundColor = backgroundColor ??
          (isDark
              ? theme.colorScheme.error.withOpacity(0.2)
              : theme.colorScheme.error.withOpacity(0.1));
      effectiveBorderColor = borderColor ?? theme.colorScheme.error;
    } else if (isSelected) {
      effectiveBackgroundColor = backgroundColor ??
          (isDark
              ? theme.colorScheme.primary.withOpacity(0.15)
              : theme.colorScheme.primary.withOpacity(0.1));
      effectiveBorderColor = borderColor ?? theme.colorScheme.primary;
    } else {
      effectiveBackgroundColor = backgroundColor ??
          (isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.7));
      effectiveBorderColor = borderColor ??
          (isDark
              ? Colors.white.withOpacity(0.15)
              : Colors.white.withOpacity(0.5));
    }

    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: LiquidGlassContainer(
        blur: 10.0,
        borderRadius: effectiveBorderRadius,
        tintColor: effectiveBackgroundColor,
        border: Border.all(
          color: effectiveBorderColor,
          width: isSelected ? 1.5 : 0.5,
        ),
        shadows: shadows,
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }

  Widget _buildMaterialCard(BuildContext context) {
    final theme = Theme.of(context);

    Color? bgColor;
    if (isError) {
      bgColor = theme.colorScheme.errorContainer;
    } else if (isSelected) {
      bgColor = theme.colorScheme.secondaryContainer;
    }

    return Card(
      color: bgColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 14),
      ),
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(borderRadius ?? 14),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}

/// Glass-themed filled card (replaces FilledButton)
class GlassFilledCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final bool isError;
  final EdgeInsets? padding;
  final double? borderRadius;

  const GlassFilledCard({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.isSelected = false,
    this.isError = false,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return _buildMaterialCard(context);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final effectiveBorderRadius = borderRadius ?? 14.0;

    Color backgroundColor;
    if (isError) {
      backgroundColor = isDark
          ? theme.colorScheme.error.withOpacity(0.3)
          : theme.colorScheme.error.withOpacity(0.15);
    } else if (isSelected) {
      backgroundColor = isDark
          ? theme.colorScheme.primary.withOpacity(0.2)
          : theme.colorScheme.primary.withOpacity(0.15);
    } else {
      backgroundColor = isDark
          ? Colors.white.withOpacity(0.1)
          : Colors.white.withOpacity(0.8);
    }

    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: LiquidGlassContainer(
        blur: 12.0,
        borderRadius: effectiveBorderRadius,
        tintColor: backgroundColor,
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }

  Widget _buildMaterialCard(BuildContext context) {
    final theme = Theme.of(context);

    Color? bgColor;
    if (isError) {
      bgColor = theme.colorScheme.errorContainer;
    } else if (isSelected) {
      bgColor = theme.colorScheme.secondaryContainer;
    } else {
      bgColor = theme.colorScheme.surfaceContainerHigh;
    }

    return FilledButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: FilledButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
        ),
      ),
      child: child,
    );
  }
}

/// Glass-themed outlined card (replaces OutlinedButton)
class GlassOutlinedCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final bool isError;
  final EdgeInsets? padding;
  final double? borderRadius;

  const GlassOutlinedCard({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.isSelected = false,
    this.isError = false,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return _buildMaterialCard(context);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final effectiveBorderRadius = borderRadius ?? 14.0;

    Color backgroundColor;
    Color borderColor;

    if (isError) {
      backgroundColor = isDark
          ? theme.colorScheme.error.withOpacity(0.1)
          : theme.colorScheme.error.withOpacity(0.05);
      borderColor = theme.colorScheme.error;
    } else if (isSelected) {
      backgroundColor = isDark
          ? theme.colorScheme.primary.withOpacity(0.1)
          : theme.colorScheme.primary.withOpacity(0.05);
      borderColor = theme.colorScheme.primary;
    } else {
      backgroundColor = isDark
          ? Colors.white.withOpacity(0.05)
          : Colors.white.withOpacity(0.6);
      borderColor = isDark
          ? Colors.white.withOpacity(0.2)
          : Colors.white.withOpacity(0.5);
    }

    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: LiquidGlassContainer(
        blur: 10.0,
        borderRadius: effectiveBorderRadius,
        tintColor: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: isSelected ? 1.5 : 1.0,
        ),
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }

  Widget _buildMaterialCard(BuildContext context) {
    final theme = Theme.of(context);

    Color? bgColor;
    Color? borderColor;

    if (isError) {
      bgColor = theme.colorScheme.errorContainer.withOpacity(0.1);
      borderColor = theme.colorScheme.error;
    } else if (isSelected) {
      bgColor = theme.colorScheme.secondaryContainer;
      borderColor = theme.colorScheme.primary;
    } else {
      bgColor = theme.colorScheme.surfaceContainerLow;
      borderColor = theme.colorScheme.outline;
    }

    return OutlinedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: OutlinedButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        backgroundColor: bgColor,
        side: BorderSide(color: borderColor ?? Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
        ),
      ),
      child: child,
    );
  }
}
