import 'package:flutter/widgets.dart';

import '../../../../l10n/translations.dart';

///
/// Extensions for [BuildContext] class
///
extension BuildContextExt on BuildContext {
  ///
  /// Get [Translation] from current context
  ///
  Tr get tr {
    return Tr.of(this);
  }
}
