import 'package:flutter/material.dart';
import 'glass_effects.dart';
import 'glass_platform.dart';

/// Glass-themed list tile
class GlassListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsets? contentPadding;
  final double? minVerticalPadding;
  final double? minTileHeight;
  final Color? tileColor;

  const GlassListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.contentPadding,
    this.minVerticalPadding,
    this.minTileHeight,
    this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
        contentPadding: contentPadding,
        minVerticalPadding: minVerticalPadding,
        minTileHeight: minTileHeight,
        tileColor: tileColor,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyLarge!,
                      child: title,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall!,
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 16),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Glass-themed switch
class GlassSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;

  const GlassSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return Switch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
        activeTrackColor: activeTrackColor,
        inactiveThumbColor: inactiveThumbColor,
        inactiveTrackColor: inactiveTrackColor,
      );
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: value
              ? (activeColor ?? theme.colorScheme.primary)
              : (inactiveTrackColor ??
                  (isDark ? Colors.grey[700] : Colors.grey[300])),
          border: Border.all(
            color: value
                ? (activeColor ?? theme.colorScheme.primary).withOpacity(0.5)
                : (isDark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.1)),
            width: 1,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value
                  ? (activeTrackColor ?? Colors.white)
                  : (inactiveThumbColor ??
                      (isDark ? Colors.grey[300] : Colors.white)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Glass-themed checkbox
class GlassCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final bool isCircle;

  const GlassCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.checkColor,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      if (isCircle) {
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value
                ? (activeColor ?? Theme.of(context).colorScheme.primary)
                : Colors.transparent,
            border: Border.all(
              color: value
                  ? (activeColor ?? Theme.of(context).colorScheme.primary)
                  : Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
          child: value
              ? Icon(
                  Icons.check,
                  size: 16,
                  color: checkColor ?? Colors.white,
                )
              : null,
        );
      }
      return Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
        checkColor: checkColor,
      );
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : BorderRadius.circular(4),
          color: value
              ? (activeColor ?? theme.colorScheme.primary)
              : Colors.transparent,
          border: Border.all(
            color: value
                ? (activeColor ?? theme.colorScheme.primary)
                : (isDark
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.3)),
            width: 2,
          ),
        ),
        child: value
            ? Icon(
                Icons.check,
                size: 16,
                color: checkColor ?? Colors.white,
              )
            : null,
      ),
    );
  }
}

/// Glass-themed radio
class GlassRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? activeColor;

  const GlassRadio({
    super.key,
    required this.value,
    this.groupValue,
    this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return Radio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: activeColor,
      );
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? (activeColor ?? theme.colorScheme.primary)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? (activeColor ?? theme.colorScheme.primary)
                : (isDark
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.3)),
            width: 2,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

/// Glass-themed progress indicator
class GlassProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final double? strokeWidth;

  const GlassProgressIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      if (value != null) {
        return CircularProgressIndicator(
          value: value,
          color: color,
          backgroundColor: backgroundColor,
          strokeWidth: strokeWidth ?? 4.0,
        );
      }
      return CircularProgressIndicator(
        color: color,
        backgroundColor: backgroundColor,
        strokeWidth: strokeWidth ?? 4.0,
      );
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        value: value,
        color: color ?? theme.colorScheme.primary,
        backgroundColor: backgroundColor ??
            (isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1)),
        strokeWidth: strokeWidth ?? 3.0,
      ),
    );
  }
}
