class ClaimsEntity {
  final String customerId;
  final String phoneNumber;
  final String picture;
  final String userId;
  final String aud;
  final int exp;
  final int iat;
  final String iss;
  final String sub;
  final String name;
  final String email;
  final bool emailVerified;
  final String sellerId;
  final String marketplaceId;
  final int authTime;

  ClaimsEntity({
    required this.customerId,
    required this.phoneNumber,
    required this.picture,
    required this.userId,
    required this.aud,
    required this.exp,
    required this.iat,
    required this.iss,
    required this.sub,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.sellerId,
    required this.marketplaceId,
    required this.authTime,
  });
}
