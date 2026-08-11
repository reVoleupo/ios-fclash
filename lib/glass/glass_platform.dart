import 'dart:io';

/// Glass rendering mode
enum GlassRenderMode {
  /// Full Liquid Glass effect (iOS/macOS/Android with Impeller)
  liquidGlass,

  /// Lightweight glass effect (fallback for low-performance devices)
  fakeGlass,

  /// Material design (Windows/Linux compatibility)
  material,
}

/// Platform detection and degradation strategy
class GlassPlatform {
  /// Get the current render mode based on platform
  static GlassRenderMode get renderMode {
    if (Platform.isIOS || Platform.isMacOS) {
      return GlassRenderMode.liquidGlass;
    }
    if (Platform.isAndroid) {
      // Android uses Impeller by default since Flutter 3.16
      return GlassRenderMode.liquidGlass;
    }
    // Windows/Linux don't support Impeller
    return GlassRenderMode.material;
  }

  /// Whether the platform supports Impeller rendering
  static bool get supportsImpeller {
    return Platform.isIOS || Platform.isMacOS || Platform.isAndroid;
  }

  /// Whether to use Liquid Glass effects
  static bool get useLiquidGlass {
    return renderMode == GlassRenderMode.liquidGlass;
  }

  /// Whether to use Material design fallback
  static bool get useMaterial {
    return renderMode == GlassRenderMode.material;
  }

  /// Get platform-specific Glass settings
  static GlassPlatformSettings get settings {
    if (Platform.isIOS) {
      return const GlassPlatformSettings(
        blur: 12.0,
        thickness: 15.0,
        lightIntensity: 1.5,
        ambientStrength: 0.1,
        outlineIntensity: 0.5,
        saturation: 1.2,
        borderRadius: 14.0,
      );
    }
    if (Platform.isMacOS) {
      return const GlassPlatformSettings(
        blur: 10.0,
        thickness: 12.0,
        lightIntensity: 1.3,
        ambientStrength: 0.1,
        outlineIntensity: 0.4,
        saturation: 1.1,
        borderRadius: 12.0,
      );
    }
    if (Platform.isAndroid) {
      return const GlassPlatformSettings(
        blur: 10.0,
        thickness: 12.0,
        lightIntensity: 1.4,
        ambientStrength: 0.1,
        outlineIntensity: 0.5,
        saturation: 1.2,
        borderRadius: 14.0,
      );
    }
    // Default settings
    return const GlassPlatformSettings(
      blur: 10.0,
      thickness: 15.0,
      lightIntensity: 1.5,
      ambientStrength: 0.1,
      outlineIntensity: 0.5,
      saturation: 1.2,
      borderRadius: 14.0,
    );
  }
}

/// Platform-specific Glass settings
class GlassPlatformSettings {
  final double blur;
  final double thickness;
  final double lightIntensity;
  final double ambientStrength;
  final double outlineIntensity;
  final double saturation;
  final double borderRadius;

  const GlassPlatformSettings({
    required this.blur,
    required this.thickness,
    required this.lightIntensity,
    required this.ambientStrength,
    required this.outlineIntensity,
    required this.saturation,
    required this.borderRadius,
  });

  GlassPlatformSettings copyWith({
    double? blur,
    double? thickness,
    double? lightIntensity,
    double? ambientStrength,
    double? outlineIntensity,
    double? saturation,
    double? borderRadius,
  }) {
    return GlassPlatformSettings(
      blur: blur ?? this.blur,
      thickness: thickness ?? this.thickness,
      lightIntensity: lightIntensity ?? this.lightIntensity,
      ambientStrength: ambientStrength ?? this.ambientStrength,
      outlineIntensity: outlineIntensity ?? this.outlineIntensity,
      saturation: saturation ?? this.saturation,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
