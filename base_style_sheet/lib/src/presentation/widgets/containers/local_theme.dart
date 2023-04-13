import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/themes/theme_factory.dart';
import '../../../../features/app/presentation/extensions/build_context_extensions.dart';

class LocalTheme extends StatelessWidget {
  final WidgetBuilder builder;

  final ThemeData theme;

  final SystemUiOverlayStyle? systemUiOverlayStyle;

  const LocalTheme._({
    Key? key,
    required this.builder,
    required this.theme,
    this.systemUiOverlayStyle,
  }) : super(key: key);

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
      child: Builder(builder: (context) => builder(context)),
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
