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
  final String appBaseUrl;
  final String pwaBaseUrl;
  final String dynamicLinkDomain;
  final String iosBundleId;
  final String androidBundleId;
  final String zendeskAccountKey;
  final String zendeskAppId;
  final String sentryDsn;
  final String baseUrlParking;
  final String mixpanelToken;
  final String endpointCampaign;
  final String getmoKey;
  final String getmoSecret;
  final String endpointGraphql;

  final ThemeVersion themeVersion;
  final ThemeMode themeMode;

  EnvironmentEntity({
    this.appBaseUrl = '',
    this.pwaBaseUrl = '',
    this.dynamicLinkDomain = '',
    this.iosBundleId = '',
    this.androidBundleId = '',
    this.zendeskAccountKey = '',
    this.zendeskAppId = '',
    this.sentryDsn = '',
    this.baseUrlParking = '',
    this.mixpanelToken = '',
    this.endpointCampaign = '',
    this.getmoKey = '',
    this.getmoSecret = '',
    this.endpointGraphql = '',
    this.appName,
    this.flavor,
    this.themeMode = ThemeMode.light,
    this.themeVersion = ThemeVersion.v1,
  });
}
