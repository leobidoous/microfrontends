class InvestimentQueries {

  static const String getOpenBankingInvestment = r'''
    query listOpenBankingInvestments($linkIds: [UUID4!], $pagination: PaginationParams) {
        listOpenBankingInvestments(linkIds: $linkIds, pagination: $pagination) {
          averageAcquisitionPrice
          balanceGross
          balanceNet
          currency
          id
          link {
            id
            status
            accessMode
            institution
          }
          name
          openDate
          price
          profit
          quantity
          subtype
          type
        }
      }
  ''';

}