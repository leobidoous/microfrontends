import 'package:core/core.dart' show TokenEntity;

class SSOConfigEntity {
  final String scope;
  final TokenEntity? token;
  final String responseType;
  final String clientId;
  final String tenantId;
  final String clientSecret;
  final String redirectUri;

  SSOConfigEntity({
    this.scope = 'openid profile offline_access',
    this.token,
    this.responseType = 'code',
    this.clientId = '',
    this.tenantId = '',
    this.clientSecret = '',
    this.redirectUri = '',
  });
}
