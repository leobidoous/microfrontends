class TokenEntity {
  final String accessToken;
  final String customToken;
  final String refreshToken;
  final String expiresIn;

  TokenEntity({
    required this.accessToken,
    required this.customToken,
    required this.refreshToken,
    required this.expiresIn,
  });
}
