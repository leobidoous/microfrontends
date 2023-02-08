import 'package:flutter/material.dart';

import '../../core/enums/flavors_enum.dart';


///
/// App theme versions
///
enum ThemeVersion {
  /// Initial version
  v1,

  /// Version 2.0
  v2
}

class EnvironmentEntity {
  final String? appName;
  final Flavor? flavor;
  final String baseUrl;
  final String? microsoftUrl;
  final String? onBoardingBaseUrl;
  final String? whitelabel;
  final String? homeRoute;
  final String api;
  final String? clientId;
  final String? clientSecret;
  final String? tenantId;
  final String? redirectUri;
  final ThemeVersion themeVersion;
  final ThemeMode themeMode;

  EnvironmentEntity({
    this.appName,
    this.microsoftUrl,
    this.baseUrl = '',
    this.whitelabel,
    this.onBoardingBaseUrl,
    this.homeRoute,
    this.flavor,
    this.api = '',
    this.clientId,
    this.clientSecret,
    this.tenantId,
    this.redirectUri,
    this.themeMode = ThemeMode.light,
    this.themeVersion = ThemeVersion.v1,
  });
}
