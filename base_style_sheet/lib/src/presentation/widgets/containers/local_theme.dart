import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// Applies a custom theme to a pre-defined area.
///
/// Get the correct theme from [Environment] settings.
///
class LocalTheme extends StatelessWidget {
  ///
  /// Widget builder that provides a BuildContext with correct Theme applied.
  ///
  final WidgetBuilder builder;

  ///
  /// Set a specific theme to part of the widget tree.
  ///
  final ThemeData theme;

  ///
  /// Used to change [SystemUiOverlayStyle].
  ///
  /// Specifies a preference for the style of the system overlays.
  /// If not null will apply a contrasting color to the system overlays.
  ///
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  /// Creates a [LocalTheme]
  const LocalTheme._({
    Key? key,
    required this.builder,
    required this.theme,
    this.systemUiOverlayStyle,
  }) : super(key: key);

  ///
  /// Creates an area that respects the default dark theme.
  ///
  /// If this widget is applied to a full page, remember to check
  /// [invertSystemUiOverlayStyle] to true.
  ///
  factory LocalTheme.dark({
    required WidgetBuilder builder,
    bool invertSystemUiOverlayStyle = false,
  }) {
    return LocalTheme._(
      builder: builder,
      systemUiOverlayStyle:
          invertSystemUiOverlayStyle ? SystemUiOverlayStyle.light : null,
      theme: ThemeFactory.dark(),
    );
  }

  ///
  /// Creates an area that respects the default light theme.
  ///
  /// If this widget is applied to a full page, remember to check
  /// [invertSystemUiOverlayStyle] to true.
  ///
  factory LocalTheme.light({
    required WidgetBuilder builder,
    bool invertSystemUiOverlayStyle = false,
  }) {
    return LocalTheme._(
      builder: builder,
      systemUiOverlayStyle:
          invertSystemUiOverlayStyle ? SystemUiOverlayStyle.dark : null,
      theme: ThemeFactory.light(),
    );
  }

  ///
  /// Creates an area that respects the system current theme.
  ///
  /// If this widget is applied to a full page, remember to check
  /// [invertSystemUiOverlayStyle] to true.
  ///
  factory LocalTheme.system({
    required BuildContext context,
    required WidgetBuilder builder,
    bool invertSystemUiOverlayStyle = true,
  }) {
    final isDark = context.mediaQuery.platformBrightness == Brightness.dark;

    return LocalTheme._(
      builder: builder,
      theme: isDark ? ThemeFactory.dark() : ThemeFactory.light(),
      systemUiOverlayStyle: invertSystemUiOverlayStyle
          ? isDark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark
          : null,
    );
  }

  ///
  /// Creates an area that respects a custom [ThemeData],
  ///  defined in [theme] argument.
  /// If this widget is applied to a full page, remember to also change
  /// [systemUiOverlayStyle] to a style that fits to your theme.
  ///
  factory LocalTheme.custom({
    required WidgetBuilder builder,
    required ThemeData theme,
    SystemUiOverlayStyle? systemUiOverlayStyle,
  }) {
    return LocalTheme._(
      builder: builder,
      systemUiOverlayStyle: systemUiOverlayStyle,
      theme: theme,
    );
  }

  ///
  /// Creates an area with the inverted theme, using as base
  /// the current context theme. If theme in [context] is dark,
  /// the theme applied to the builder is light and vice-versa.
  ///
  /// If this widget is applied to a full page, remember to check
  /// [invertSystemUiOverlayStyle] to true.
  ///
  factory LocalTheme.inverted({
    required BuildContext context,
    required WidgetBuilder builder,
    bool invertSystemUiOverlayStyle = true,
  }) {
    final isDark = context.mediaQuery.platformBrightness == Brightness.dark;

    return LocalTheme._(
      builder: builder,
      theme: isDark ? ThemeFactory.light() : ThemeFactory.dark(),
      systemUiOverlayStyle: invertSystemUiOverlayStyle
          ? isDark
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final styledWidget = Theme(
      data: theme,
      child: Builder(builder: builder),
    );

    if (systemUiOverlayStyle != null) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle!,
        child: styledWidget,
      );
    }
    return styledWidget;
  }
}
