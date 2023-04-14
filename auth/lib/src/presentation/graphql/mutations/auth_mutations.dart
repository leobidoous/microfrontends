class AuthMutations {
  static const String sendVerificationCode = r'''
        mutation sendVerificationCode($phoneNumber: String!, $platform: PlatformEnum) {
          sendVerificationCode(phoneNumber: $phoneNumber, platform: $platform)
        }
      ''';
  static const String validateVerificationCode = r'''
        mutation validateVerificationCode($code: String!, $phoneNumber: String!, $platform: PlatformEnum){
          validateVerificationCode(code: $code, phoneNumber: $phoneNumber, platform: $platform)
        }
      ''';
  static const String validateVerificationCodeFirebase = r'''
        mutation validateVerificationCodeFirebase($code: String!, $phoneNumber: String!, $platform: PlatformEnum) {
          validateVerificationCodeFirebase(code: $code, phoneNumber: $phoneNumber, platform: $platform) {
            accessToken
            customToken
            expiresIn
            refreshToken
          }
        }
      ''';
  static const String renewAccessToken = r'''
        mutation renewAccessToken($refreshToken: String!) {
          renewAccessToken(refreshToken: $refreshToken) {
            accessToken
            customToken
            expiresIn
            refreshToken
          }
        }
      ''';
}
