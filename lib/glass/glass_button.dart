import 'package:flutter/material.dart';
import 'glass_effects.dart';
import 'glass_platform.dart';

/// Glass-themed button
class GlassButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final IconData? icon;
  final double? iconSize;
  final bool isLoading;

  const GlassButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.onLongPress,
    this.color,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.icon,
    this.iconSize,
    this.isLoading = false,
  }) : assert(text != null || child != null);

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return _buildMaterialButton(context);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final effectiveBorderRadius = borderRadius ?? 12.0;

    final effectiveColor = color ?? theme.colorScheme.primary;
    final effectiveTextColor = textColor ?? Colors.white;

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      onLongPress: isLoading ? null : onLongPress,
      child: LiquidGlassContainer(
        blur: 8.0,
        borderRadius: effectiveBorderRadius,
        tintColor: effectiveColor.withOpacity(isDark ? 0.6 : 0.8),
        border: Border.all(
          color: effectiveColor.withOpacity(isDark ? 0.4 : 0.3),
          width: 0.5,
        ),
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: _buildContent(effectiveTextColor),
      ),
    );
  }

  Widget _buildContent(Color textColor) {
    if (isLoading) {
      return SizedBox(
        width: iconSize ?? 20,
        height: iconSize ?? 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    final children = <Widget>[];

    if (icon != null) {
      children.add(Icon(icon, size: iconSize ?? 20, color: textColor));
      if (text != null || child != null) {
        children.add(const SizedBox(width: 8));
      }
    }

    if (text != null) {
      children.add(
        Text(
          text!,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else if (child != null) {
      children.add(child!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildMaterialButton(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        onLongPress: isLoading ? null : onLongPress,
        icon: isLoading
            ? SizedBox(
                width: iconSize ?? 20,
                height: iconSize ?? 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? Colors.white,
                  ),
                ),
              )
            : Icon(icon, size: iconSize ?? 20),
        label: text != null ? Text(text!) : child ?? const SizedBox(),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      onLongPress: isLoading ? null : onLongPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: isLoading
          ? SizedBox(
              width: iconSize ?? 20,
              height: iconSize ?? 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  textColor ?? Colors.white,
                ),
              ),
            )
          : text != null
              ? Text(text!)
              : child ?? const SizedBox(),
    );
  }
}

/// Glass-themed text button
class GlassTextButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;

  const GlassTextButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.color,
    this.borderRadius,
    this.padding,
  }) : assert(text != null || child != null);

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          padding: padding,
        ),
        child: text != null ? Text(text!) : child!,
      );
    }

    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        child: text != null
            ? Text(
                text!,
                style: TextStyle(
                  color: effectiveColor,
                  fontWeight: FontWeight.w500,
                ),
              )
            : child!,
      ),
    );
  }
}

/// Glass-themed icon button
class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  final double? iconSize;
  final String? tooltip;

  const GlassIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size,
    this.iconSize,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: color,
        iconSize: iconSize,
        tooltip: tooltip,
      );
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveSize = size ?? 48;
    final effectiveIconSize = iconSize ?? 24;

    return GestureDetector(
      onTap: onPressed,
      child: Tooltip(
        message: tooltip ?? '',
        child: Container(
          width: effectiveSize,
          height: effectiveSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.5),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.15)
                  : Colors.white.withOpacity(0.3),
              width: 0.5,
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              size: effectiveIconSize,
              color: color ?? theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
