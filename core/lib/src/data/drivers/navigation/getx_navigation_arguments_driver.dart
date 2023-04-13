
import 'package:get/get.dart';

import '../../../infra/drivers/navigation/i_navigation_arguments_driver.dart';


/// [INavigationArgumentsDriver] implementation using [Get] package
class GetxNavigationArgumentsDriver implements INavigationArgumentsDriver {
  @override
  get data => Get.arguments.data;

  @override
  Map<String, dynamic> get params => Get.arguments.params;

  @override
  Map<String, String> get queryParams => Get.arguments.queryParams;

  @override
  Map<String, List<String>> get queryParamsAll => Get.arguments.queryParamsAll;

  @override
  Uri get uri => Get.arguments.uri;
}
