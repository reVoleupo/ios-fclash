import 'package:flutter/material.dart';
import 'glass_effects.dart';
import 'glass_platform.dart';

/// Glass-themed chip
class GlassChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final VoidCallback? onDelete;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final bool isSelected;
  final bool isEnabled;

  const GlassChip({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.onDelete,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.borderRadius,
    this.padding,
    this.isSelected = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return Chip(
        label: Text(label),
        avatar: icon != null ? Icon(icon, size: 18) : null,
        onDeleted: onDelete,
        backgroundColor: backgroundColor,
        labelStyle: TextStyle(color: textColor),
        deleteIconColor: iconColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
        padding: padding,
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final effectiveBorderRadius = borderRadius ?? 20.0;

    Color effectiveBackgroundColor;
    Color effectiveTextColor;
    Color effectiveBorderColor;

    if (isSelected) {
      effectiveBackgroundColor = backgroundColor ??
          (isDark
              ? theme.colorScheme.primary.withOpacity(0.3)
              : theme.colorScheme.primary.withOpacity(0.15));
      effectiveTextColor = textColor ?? theme.colorScheme.primary;
      effectiveBorderColor = theme.colorScheme.primary;
    } else {
      effectiveBackgroundColor = backgroundColor ??
          (isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.6));
      effectiveTextColor = textColor ?? theme.colorScheme.onSurface;
      effectiveBorderColor = isDark
          ? Colors.white.withOpacity(0.15)
          : Colors.white.withOpacity(0.3);
    }

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          border: Border.all(
            color: effectiveBorderColor,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: iconColor ?? effectiveTextColor,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: effectiveTextColor,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: effectiveTextColor.withOpacity(0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Glass-themed action chip
class GlassActionChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;

  const GlassActionChip({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return ActionChip(
        label: Text(label),
        avatar: icon != null ? Icon(icon, size: 18) : null,
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        labelStyle: TextStyle(color: textColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
      );
    }

    return GlassChip(
      label: label,
      icon: icon,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderRadius: borderRadius,
    );
  }
}

/// Glass-themed filter chip
class GlassFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? textColor;
  final double? borderRadius;

  const GlassFilterChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
    this.icon,
    this.backgroundColor,
    this.selectedColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected,
        avatar: icon != null ? Icon(icon, size: 18) : null,
        backgroundColor: backgroundColor,
        selectedColor: selectedColor,
        labelStyle: TextStyle(color: textColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
      );
    }

    return GlassChip(
      label: label,
      icon: icon,
      onPressed: onSelected != null ? () => onSelected!(!selected) : null,
      backgroundColor: selected ? selectedColor : backgroundColor,
      textColor: textColor,
      borderRadius: borderRadius,
      isSelected: selected,
    );
  }
}
