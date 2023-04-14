class CreditCardQueries {
  static const String getCreditCard = r'''
        query getCreditCard($id: UUID4!) {
          getCreditCard(id: $id) {
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

  static const String listCreditCards = r'''
        query listCreditCards($customerId: UUID4!) {
          listCreditCards(customerId: $customerId) {
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
