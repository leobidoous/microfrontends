abstract class INavigationArgumentsDriver {
  Map<String, dynamic> get params;
  Uri get uri;
  dynamic get data;
  Map<String, String> get queryParams => uri.queryParameters;
  Map<String, List<String>> get queryParamsAll => uri.queryParametersAll;
}
