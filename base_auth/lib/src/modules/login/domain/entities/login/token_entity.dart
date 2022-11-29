class TokenEntity {
  final int expireOffSet;
  final String accessToken;
  final String idToken;
  final String tokenType;
  final String refreshToken;
  final DateTime issueTimeStamp;
  final DateTime expireTimeStamp;
  final int expiresIn;

  TokenEntity({
    this.expireOffSet = 5,
    required this.accessToken,
    required this.idToken,
    required this.tokenType,
    required this.refreshToken,
    required this.issueTimeStamp,
    required this.expireTimeStamp,
    required this.expiresIn,
  });
}
