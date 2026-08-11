import 'dart:ui';
import 'package:flutter/material.dart';
import 'glass_effects.dart';
import 'glass_platform.dart';

/// Glass-themed dialog
class GlassDialog extends StatelessWidget {
  final String? title;
  final Widget child;
  final List<Widget>? actions;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final bool scrollable;

  const GlassDialog({
    super.key,
    this.title,
    required this.child,
    this.actions,
    this.contentPadding,
    this.borderRadius,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return AlertDialog(
        title: title != null ? Text(title!) : null,
        content: child,
        actions: actions,
        contentPadding: contentPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 28),
        ),
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBorderRadius = borderRadius ?? 28.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.grey[900]!.withOpacity(0.9)
                  : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.15)
                    : Colors.white.withOpacity(0.5),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.5 : 0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Text(
                      title!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                Flexible(
                  child: scrollable
                      ? SingleChildScrollView(
                          padding: contentPadding ??
                              const EdgeInsets.symmetric(horizontal: 24),
                          child: child,
                        )
                      : Padding(
                          padding: contentPadding ??
                              const EdgeInsets.symmetric(horizontal: 24),
                          child: child,
                        ),
                ),
                if (actions != null && actions!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions!
                          .map((action) => Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: action,
                              ))
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Show a glass dialog
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget child,
    List<Widget>? actions,
    EdgeInsets? contentPadding,
    double? borderRadius,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black38,
      builder: (context) => GlassDialog(
        title: title,
        actions: actions,
        contentPadding: contentPadding,
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}

/// Glass-themed bottom sheet
class GlassBottomSheet extends StatelessWidget {
  final String? title;
  final Widget child;
  final List<Widget>? actions;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final bool isScrollControlled;

  const GlassBottomSheet({
    super.key,
    this.title,
    required this.child,
    this.actions,
    this.contentPadding,
    this.borderRadius,
    this.isScrollControlled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(borderRadius ?? 28),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            Padding(
              padding: contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 24),
              child: child,
            ),
            if (actions != null && actions!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ),
          ],
        ),
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBorderRadius = borderRadius ?? 28.0;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(effectiveBorderRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? Colors.grey[900]!.withOpacity(0.95)
                : Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(effectiveBorderRadius),
            ),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.15)
                  : Colors.white.withOpacity(0.5),
              width: 0.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.3)
                        : Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: Text(
                    title!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              Flexible(
                child: Padding(
                  padding: contentPadding ??
                      const EdgeInsets.symmetric(horizontal: 24),
                  child: child,
                ),
              ),
              if (actions != null && actions!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Show a glass bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget child,
    List<Widget>? actions,
    EdgeInsets? contentPadding,
    double? borderRadius,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassBottomSheet(
        title: title,
        actions: actions,
        contentPadding: contentPadding,
        borderRadius: borderRadius,
        isScrollControlled: isScrollControlled,
        child: child,
      ),
    );
  }
}

/// Glass-themed snackbar/notification
class GlassSnackbar extends StatelessWidget {
  final String message;
  final Widget? action;
  final Duration duration;
  final VoidCallback? onVisible;

  const GlassSnackbar({
    super.key,
    required this.message,
    this.action,
    this.duration = const Duration(seconds: 4),
    this.onVisible,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return SnackBar(
        content: Text(message),
        action: action != null
            ? SnackBarAction(
                label: 'OK',
                onPressed: () {},
              )
            : null,
        duration: duration,
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.grey[800]!.withOpacity(0.9)
                : Colors.grey[900]!.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.white.withOpacity(0.05),
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (action != null) action!,
            ],
          ),
        ),
      ),
    );
  }

  /// Show a glass snackbar
  static void show({
    required BuildContext context,
    required String message,
    Widget? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GlassSnackbar(
          message: message,
          action: action,
          duration: duration,
        ),
        duration: duration,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
