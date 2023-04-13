class CustomerMutations {
  static const String updateCustomer = r'''
        mutation updateCustomer($id: UUID4!, $params: UpdateCustomerParams) {
          updateCustomer(id: $id, params: $params) {
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

  static const String getCustomer = r'''
        query getCustomer($id: UUID4!){
          getCustomer(id: $id) {
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
}
