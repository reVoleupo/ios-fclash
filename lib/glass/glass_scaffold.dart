import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'glass_effects.dart';
import 'glass_platform.dart';

/// Glass-themed scaffold that replaces Material Scaffold
class GlassScaffold extends StatefulWidget {
  final AppBar? appBar;
  final Widget body;
  final Color? backgroundColor;
  final String? title;
  final bool isLoading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;

  const GlassScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.backgroundColor,
    this.title,
    this.actions,
    this.centerTitle,
    this.isLoading = false,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
  });

  @override
  State<GlassScaffold> createState() => _GlassScaffoldState();
}

class _GlassScaffoldState extends State<GlassScaffold> {
  final ValueNotifier<bool> _isFabExtendedNotifier = ValueNotifier(true);

  @override
  void dispose() {
    _isFabExtendedNotifier.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildGlassAppBar(BuildContext context) {
    if (widget.appBar != null) {
      return widget.appBar!;
    }

    if (widget.title == null) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: LiquidGlassContainer(
        blur: 10.0,
        borderRadius: 0,
        tintColor: isDark
            ? Colors.black.withOpacity(0.3)
            : Colors.white.withOpacity(0.8),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              if (Navigator.of(context).canPop())
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              Expanded(
                child: Text(
                  widget.title!,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign:
                      widget.centerTitle == true ? TextAlign.center : TextAlign.start,
                ),
              ),
              if (widget.actions != null) ...widget.actions!,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          widget.backgroundColor ?? (isDark ? Colors.black : Colors.grey[100]),
      appBar: _buildGlassAppBar(context),
      body: NotificationListener<UserScrollNotification>(
        child: widget.body,
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            _isFabExtendedNotifier.value = false;
          } else if (notification.direction == ScrollDirection.forward) {
            _isFabExtendedNotifier.value = true;
          }
          return true;
        },
      ),
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      floatingActionButton: widget.floatingActionButton != null
          ? ValueListenableBuilder<bool>(
              valueListenable: _isFabExtendedNotifier,
              builder: (_, isExtended, child) {
                return child!;
              },
              child: widget.floatingActionButton,
            )
          : null,
    );
  }
}

/// Glass-themed app bar
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? centerTitle;
  final double elevation;
  final Color? backgroundColor;

  const GlassAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle,
    this.elevation = 0,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LiquidGlassContainer(
      blur: 10.0,
      borderRadius: 0,
      tintColor: backgroundColor ??
          (isDark
              ? Colors.black.withOpacity(0.3)
              : Colors.white.withOpacity(0.8)),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (leading != null)
              leading!
            else if (Navigator.of(context).canPop())
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            Expanded(
              child: title != null
                  ? Text(
                      title!,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: centerTitle == true
                          ? TextAlign.center
                          : TextAlign.start,
                    )
                  : Container(),
            ),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
}
