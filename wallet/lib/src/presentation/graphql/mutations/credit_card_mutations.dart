class CreditCardMutations {
  static const String tokenizeCardNumber = r'''
        mutation tokenizeCardNumber($cardNumber: String!) {
          tokenizeCardNumber(cardNumber: $cardNumber)
        }
      ''';

  static const String createCreditCard = r'''
        mutation createCreditCard($params: CreateCreditCardParams!) {
          createCreditCard(params: $params) {
            id
            blocked
            brand
            expirationMonth
            expirationYear
            holderName
            default
            last4
            marketplace {
              id
            }
            token
            verified
            billingAddress {
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
          }
        }
      ''';

  static const String updateCreditCard = r'''
        mutation updateCreditCard($id: UUID4!, $params: UpdateCreditCardParams!) {
          updateCreditCard(id: $id, params: $params) {
            id
            blocked
            brand
            expirationMonth
            expirationYear
            holderName
            default
            last4
            marketplace {
              id
            }
            token
            verified
            billingAddress {
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
          }
        }
      ''';

  static const String deleteCreditCard = r'''
        mutation deleteCreditCard($id: UUID4!) {
          deleteCreditCard(id: $id) {
            id
            blocked
            brand
            expirationMonth
            expirationYear
            holderName
            default
            last4
            marketplace {
              id
            }
            token
            verified
            billingAddress {
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
          }
        }
      ''';
}
