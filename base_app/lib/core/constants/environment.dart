import '../enums/flavors_enum.dart';

class Environment {
  final String? appName;
  final Flavor? flavor;
  final String? baseUrl;
  final String? microsoftUrl;
  final String? onBoardingBaseUrl;
  final String? whitelabel;
  final String? homeRoute;
  final String? api;
  final String? clientId;
  final String? clientSecret;
  final String? tenantId;
  final String? redirectUri;

  Environment({
    this.appName,
    this.microsoftUrl,
    this.baseUrl,
    this.whitelabel,
    this.onBoardingBaseUrl,
    this.homeRoute,
    this.flavor,
    this.api,
    this.clientId,
    this.clientSecret,
    this.tenantId,
    this.redirectUri,
  });
}
