class LinkMutations {

  static const String createCustomerOpenBankingLinkReference = r'''
    mutation($customer_id: UUID4!, $params: CreateOpenBankingLinkReferenceParams!) {
      createCustomerOpenBankingLinkReference(customerId: $customer_id, params: $params) {
        id
      }
    }
  ''';
  
  static const String createCustomerOpenBankingLink = r'''
      mutation createCustomerOpenBankingLink($customerId: UUID4!, $params: CreateOpenBankingLinkParams!) {
        createCustomerOpenBankingLink(customerId: $customerId, params: $params) {
          accessMode
          company {
            id
          }
          createdBy
          customer {
            id
          }
          externalId
          id
          institution
          institutionUserId
          lastAccessedAt
          refreshRate
          seller {
            id
          }
          status
        }
      }
  ''';

  static const String createSellerOpenBankingLink = r'''
       mutation createSellerOpenBankingLink($params: CreateOpenBankingLinkParams!, $sellerId: UUID4!) {
         createSellerOpenBankingLink(params: $params, sellerId: $sellerId) {
           accessMode
           company {
             id
           }
           createdBy
           customer {
             id
           }
           externalId
           id
           institution
           institutionUserId
           lastAccessedAt
           refreshRate
           seller {
             id
           }
           status
         }
       }
  ''';

  static const String deleteOpenBankingLink = r'''
       mutation deleteOpenBankingLink($id: UUID4!) {
         deleteOpenBankingLink(id: $id) {
           accessMode
           company {
             id
           }
           createdBy
           customer {
             id
           }
           externalId
           id
           institution
           institutionUserId
           lastAccessedAt
           refreshRate
           seller {
             id
           }
           status
         }
       }
  ''';

}