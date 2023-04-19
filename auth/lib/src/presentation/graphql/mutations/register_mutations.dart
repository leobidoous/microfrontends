class RegisterMutations {
  static const String startCustomerOnboarding = r'''
        mutation startCustomerOnboarding($cpf: String!, $name: String!, $phoneNumber: String!) {
          startCustomerOnboarding(cpf: $cpf, name: $name, phoneNumber: $phoneNumber)
        }
      ''';

  static const String validateVerificationCode = r'''
        mutation validateVerificationCode($phoneNumber: String!, $code: String!){
          validateVerificationCode(phoneNumber: $phoneNumber, code: $code)
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
