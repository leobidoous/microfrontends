import 'package:flutter/material.dart';

import '../../core/themes/app_theme_factory.dart';

/// String extensions for digital account
extension StringExtension on String {
  /// Get rich text with bold string
  Widget toRichText(BuildContext context, {required TextStyle style}) {
    final textParts = _getParts(this);
    final boldMatches = _getMatches(RegExp(r'<b>(.+?)</b>'), this);

    return RichText(
      text: TextSpan(
        children: textParts
            .map(
              (t) => boldMatches.contains('<b>$t</b>')
                  ? TextSpan(
                      text: t,
                      style: style.copyWith(
                        fontWeight: context.textTheme.fontWeightBold,
                      ),
                    )
                  : TextSpan(
                      text: t,
                      style: style.copyWith(
                        fontWeight: context.textTheme.fontWeightRegular,
                      ),
                    ),
            )
            .toList(),
      ),
    );
  }

  List<String> _getMatches(RegExp pattern, String text) {
    return pattern
        .allMatches(text)
        .map((e) => e.group(0))
        .whereType<String>()
        .toList();
  }

  List<String> _getParts(String text) {
    return text.split(RegExp(r'<[^>]*>'));
  }

  String get capitalize {
    if (length == 1) return toUpperCase();
    return split(' ').map((e) {
      if (e.length == 1) return e.toUpperCase();
      return e.substring(0, 1).toUpperCase() + e.substring(1).toLowerCase();
    }).join(' ');
  }
}
