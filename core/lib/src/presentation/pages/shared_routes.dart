import '../../core/utils/base_path.dart';

class SharedRoutes {
  static const BasePath root = BasePath('/shared/', AppRoutes.root);
  static const BasePath splash = BasePath('/splash/', root);
  static const BasePath comming = BasePath('/comming_soon/', root);
  static const BasePath regulation = BasePath('/regulation/', root);
  static const BasePath warningNewVersion = BasePath('/warning_new_version/', root);
  static const BasePath fallback = BasePath('/fallback/', root);
  static const BasePath scanBardCode = BasePath('/scar_bar_code/', root);
  static const BasePath enterTicketNumber = BasePath(
    '/enter_ticket_number/',
    scanBardCode,
  );
}
