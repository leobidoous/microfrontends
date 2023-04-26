class RegisterMutations {
  static const String startCustomerOnboarding = r'''
        mutation startCustomerOnboarding($cpf: String!, $name: String!, $phoneNumber: String!) {
          startCustomerOnboarding(cpf: $cpf, name: $name, phoneNumber: $phoneNumber)
        }
      ''';

  static const String validateVerificationCodeFirebase = r'''
        mutation validateVerificationCodeFirebase($code: String!, $phoneNumber: String!) {
          validateVerificationCodeFirebase(code: $code, phoneNumber: $phoneNumber) {
            accessToken
            customToken
            expiresIn
            refreshToken
          }
        }
      ''';

  static const String finishCustomerOnboarding = r'''
        mutation finishCustomerOnboarding($params: FinishCustomerOnboardingParams!) {
          finishCustomerOnboarding(params: $params) {
            address {
              city
              countryCode
              id
              line1
              line2
              line3
              neighborhood
              postalCode
              state
            }
            birthDate
            cnpj
            cpf
            email
            emailVerifiedAt
            id
            marketplace {
              id
            }
            name
            phone
            phoneVerifiedAt
            termAcceptedAt
            termVersion
          }
        }
      ''';

  static const String sendCustomerEmailVerificationCode = r'''
        mutation sendCustomerEmailVerificationCode {
          sendCustomerEmailVerificationCode
        }
      ''';

  static const String validateCustomerEmailVerificationCode = r'''
        mutation validateCustomerEmailVerificationCode($token: String!) {
          validateCustomerEmailVerificationCode(token: $token)
        }
      ''';
}
