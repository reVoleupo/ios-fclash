/// Glass UI component library for FlClash
///
/// This library provides Liquid Glass-styled widgets that replace Material You components
/// while maintaining the same public API for backward compatibility.
///
/// Key features:
/// - Liquid Glass visual effects (blur, transparency, light refraction)
/// - Platform-aware degradation (iOS/macOS/Android use full effects, Windows/Linux use Material)
/// - Same public API as Material widgets for seamless migration
///
/// Usage:
/// ```dart
/// import 'package:fl_clash/glass/glass.dart';
///
/// // Use GlassScaffold instead of CommonScaffold
/// GlassScaffold(
///   title: 'My Page',
///   body: Container(),
/// )
///
/// // Use GlassCard instead of Material Card
/// GlassCard(
///   onPressed: () {},
///   child: Text('Hello'),
/// )
/// ```

library glass;

// Platform detection and settings
export 'glass_platform.dart';

// Theme system
export 'glass_theme.dart';

// Core effects
export 'glass_effects.dart';

// UI Components
export 'glass_scaffold.dart';
export 'glass_card.dart';
export 'glass_list.dart';
export 'glass_dialog.dart';
export 'glass_button.dart';
export 'glass_input.dart';
export 'glass_chip.dart';
export 'glass_navigation.dart';
