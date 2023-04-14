class TransactionQueries {
  static const String listCustomerPayments = r'''
        query listCustomerPayments($customerId: UUID4!, $filters: FilterCustomerPaymentsParams, $pagination: PaginationParams) {
          listCustomerPayments(customerId: $customerId, filters: $filters, pagination: $pagination) {
            method
            totalCents
            confirmedAt
            insertedAt
            updatedAt
            publicSeller {
              id
              displayName
              person {
                name
              }
              company {
                businessName
                tradeName
              }
            }
          }
        }
      ''';
}
