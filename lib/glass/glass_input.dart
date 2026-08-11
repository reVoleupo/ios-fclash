import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'glass_effects.dart';
import 'glass_platform.dart';

/// Glass-themed text field
class GlassTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? style;
  final FocusNode? focusNode;

  const GlassTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    this.style,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    if (!GlassPlatform.useLiquidGlass) {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
          filled: true,
          fillColor: fillColor,
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        autofocus: autofocus,
        readOnly: readOnly,
        enabled: enabled,
        style: style,
        focusNode: focusNode,
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final effectiveBorderRadius = borderRadius ?? 12.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: fillColor ??
                (isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.white.withOpacity(0.7)),
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            border: Border.all(
              color: borderColor ??
                  (isDark
                      ? Colors.white.withOpacity(0.15)
                      : Colors.white.withOpacity(0.3)),
              width: 0.5,
            ),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              errorText: errorText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            autofocus: autofocus,
            readOnly: readOnly,
            enabled: enabled,
            style: style ??
                TextStyle(
                  color: theme.colorScheme.onSurface,
                ),
            focusNode: focusNode,
          ),
        ),
      ),
    );
  }
}

/// Glass-themed input decoration
class GlassInputDecoration extends InputDecoration {
  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;

  const GlassInputDecoration({
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    super.hintText,
    super.labelText,
    super.errorText,
    super.prefixIcon,
    super.suffixIcon,
    super.contentPadding,
    super.border,
    super.enabledBorder,
    super.focusedBorder,
    super.errorBorder,
    super.disabledBorder,
    super.filled,
    super.fillColor,
  });

  /// Create a Glass-themed input decoration
  factory GlassInputDecoration.glass({
    String? hintText,
    String? labelText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    EdgeInsets? contentPadding,
    double? borderRadius,
    Color? fillColor,
    Color? borderColor,
  }) {
    return GlassInputDecoration(
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      fillColor: fillColor,
      borderColor: borderColor,
    );
  }
}
