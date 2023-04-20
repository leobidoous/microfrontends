import 'dart:io' show Platform, File;

Future<void> main() async {
  final keys = [
    'APP_BASE_URL',
    'PWA_BASE_URL',
    'DYNAMIC_LINK_DOMAIN',
    'IOS_BUNDLE_ID',
    'ANDROID_BUNDLE_ID',
    'ZENDESK_ACCOUNT_KEY',
    'ZENDESK_APP_ID',
    'SENTRY_DSN',
    'BASE_URL_PARKING',
    'MIXPANEL_TOKEN',
    'ENDPOINT_CAMPAING',
    'ENDPOINT_GRAPHQL',
    'GETMO_KEY',
    'GETMO_SECRET',
  ];

  var prod = '';
  var dev = '';
  keys.forEach((e) {
    prod += '$e=${Platform.environment['$e']}\n';
    dev += '$e=${Platform.environment['DEV_$e']}\n';
  });
  await File('.environment/.env').writeAsString(prod);
  await File('.environment/.env.dev').writeAsString(dev);
}
