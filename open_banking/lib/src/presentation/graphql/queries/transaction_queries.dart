class TransactionQueries {
  
   static const String listOpenBankingTransactions = r'''
       query listOpenBankingTransactions($accountIds: [UUID4!], $filters: FilterOpenBankingTransactionParams, $pagination: PaginationParams) {
         listOpenBankingTransactions(accountIds: $accountIds, filters: $filters, pagination: $pagination) {
            account {
              balance {
                available
                current
              }
              balanceType
              bankProductId
              category
              collectedAt
              createdAt
              creditData {
                collectedAt
                creditLimit
                cuttingDate
                endDate
                interestRate
                lastPaymentDate
                lastPeriodBalance
                minimumPayment
                monthlyPayment
                nextPaymentDate
                noInterestPayment
              }
              currency
              customer {
                id
                cpf
                name
              }
              externalId
              gigPaymentData {
                balance
                name
                percentage
                type
              }
              id
              institution {
                name
                type
              }
              internalIdentification
              lastAccessedAt
              link {
                id
              }
              loanData  {
                balanceType
                bankProductId
                category
                collectedAt
                createdAt
                currency
                externalId
                internalIdentification
                lastAccessedAt
                name
                number
                publicIdentificationName
                publicIdentificationValue
                type
              }
              name
              number
              publicIdentificationName
              publicIdentificationValue
              seller {
                id
              }
              type
            }
            accountingDate
            amount
            balance
            category
            collectedAt
            creditData {
              collectedAt
              creditLimit
              cuttingDate
              endDate
              interestRate
              lastPaymentDate
              lastPeriodBalance
              minimumPayment
              monthlyPayment
              nextPaymentDate
              noInterestPayment
            }
            currency
            description
            externalId
            gigData {
              collectedAt
              creditCardData {
                billName
                collectedAt
                previousBillTotal
              }
              distance
              dropoffAddress
              dropoffAt
              dropoffLatitude
              dropoffLongitude
              merchantType
              paymentMethod
              pickupAddress
              pickupAt
              pickupLatitude
              pickupLongitude
              requestAt
              vehicleType
            }
            id
            merchant {
              logo
              merchantName
              website
            }
            observations
            reference
            status
            type
            valueDate
         }
       }
   ''';

   static const String getOpenBankingTransaction = r'''
       query getOpenBankingTransaction($id: UUID4!) {
         getOpenBankingTransaction(id: $id) {
           account {
             id
           }
           accountingDate
           amount
           balance
           category
           collectedAt
           creditData {
             collectedAt
             creditLimit
             cuttingDate
             endDate
             interestRate
             lastPaymentDate
             lastPeriodBalance
             minimumPayment
             monthlyPayment
             nextPaymentDate
             noInterestPayment
           }
           currency
           description
           externalId
           gigData {
             breakdown
             collectedAt
             creditCardData {
               billName
               collectedAt
               previousBillTotal
             }
             distance
             dropoffAddress
             dropoffAt
             dropoffLatitude
             dropoffLongitude
             merchantType
             paymentMethod
             pickupAddress
             pickupAt
             pickupLatitude
             pickupLongitude
             requestAt
             vehicleType
           }
           id
           merchant {
             logo
             merchantName
             website
           }
           observations
           reference
           type
           valueDate
         }
       }
   ''';

   static const String openBankingCategoryTransactionEnum = r'''
       query {
         __type(name:"OpenBankingCategoryTransactionEnum"){
           name
           enumValues {
             name
             description
           }
         }
       }
   ''';

}