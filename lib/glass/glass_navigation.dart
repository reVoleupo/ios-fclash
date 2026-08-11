import 'dart:ui';
import 'package:flutter/material.dart';
import 'glass_effects.dart';
import 'glass_platform.dart';

/// Glass-themed navigation bar
class GlassNavigationBar extends StatelessWidget {
  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final double? height;
  final Color? backgroundColor;

  const GlassNavigationBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    this.onDestinationSelected,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return NavigationBar(
        destinations: destinations,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        height: height,
        backgroundColor: backgroundColor,
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final effectiveHeight = height ?? 80.0;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: effectiveHeight,
          decoration: BoxDecoration(
            color: backgroundColor ??
                (isDark
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white.withOpacity(0.8)),
            border: Border(
              top: BorderSide(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.1),
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: destinations.asMap().entries.map((entry) {
                final index = entry.key;
                final destination = entry.value;
                final isSelected = index == selectedIndex;

                return GestureDetector(
                  onTap: () => onDestinationSelected?.call(index),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / destinations.length,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary.withOpacity(0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconTheme(
                            data: IconThemeData(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                              size: 24,
                            ),
                            child: destination.icon,
                          ),
                        ),
                        const SizedBox(height: 4),
                        DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          child: destination.label,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Glass-themed navigation rail
class GlassNavigationRail extends StatelessWidget {
  final List<NavigationRailDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final Widget? leading;
  final Widget? trailing;
  final double? width;
  final Color? backgroundColor;

  const GlassNavigationRail({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    this.onDestinationSelected,
    this.leading,
    this.trailing,
    this.width,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return NavigationRail(
        destinations: destinations,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        leading: leading,
        trailing: trailing,
        backgroundColor: backgroundColor,
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final effectiveWidth = width ?? 72.0;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: effectiveWidth,
          decoration: BoxDecoration(
            color: backgroundColor ??
                (isDark
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white.withOpacity(0.8)),
            border: Border(
              right: BorderSide(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.1),
                width: 0.5,
              ),
            ),
          ),
          child: Column(
            children: [
              if (leading != null) ...[
                const SizedBox(height: 12),
                leading!,
                const SizedBox(height: 12),
              ],
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: destinations.asMap().entries.map((entry) {
                    final index = entry.key;
                    final destination = entry.value;
                    final isSelected = index == selectedIndex;

                    return GestureDetector(
                      onTap: () => onDestinationSelected?.call(index),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: effectiveWidth,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? theme.colorScheme.primary.withOpacity(0.15)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: IconTheme(
                                data: IconThemeData(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurfaceVariant,
                                  size: 24,
                                ),
                                child: destination.icon,
                              ),
                            ),
                            const SizedBox(height: 4),
                            DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurfaceVariant,
                              ),
                              child: destination.label,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(height: 12),
                trailing!,
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Glass-themed tab bar
class GlassTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final double? height;

  const GlassTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.backgroundColor,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.height,
  });

  @override
  Size get preferredSize => Size.fromHeight(height ?? 48);

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return TabBar(
        tabs: tabs,
        controller: controller,
        onTap: onTap,
        indicatorColor: indicatorColor,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Container(
      height: height ?? 48,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.white.withOpacity(0.5)),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        tabs: tabs,
        controller: controller,
        onTap: onTap,
        indicatorColor: indicatorColor ?? theme.colorScheme.primary,
        labelColor: labelColor ?? theme.colorScheme.primary,
        unselectedLabelColor: unselectedLabelColor ??
            theme.colorScheme.onSurfaceVariant,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
      ),
    );
  }
}
