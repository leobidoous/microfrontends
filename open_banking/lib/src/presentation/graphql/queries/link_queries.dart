class LinkQueries {

  static const String listCustomerOpenBankingLinks = r'''
      query listCustomerOpenBankingLinks($customerId: UUID4!, $pagination: PaginationParams) {
        listCustomerOpenBankingLinks(customerId: $customerId, pagination: $pagination) {
          accessMode
          id
          institution
          status
        }
      }
  ''';
  
  static const String getOpenBankingLink = r'''
     query getOpenBankingLink($id: UUID4!) {
      getOpenBankingLink(id: $id) {
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

  static const String listSellerOpenBankingLinks = r'''
      query listSellerOpenBankingLinks($pagination: PaginationParams, $sellerId: UUID4!) {
        listSellerOpenBankingLinks(pagination: $pagination, sellerId: $sellerId) {
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