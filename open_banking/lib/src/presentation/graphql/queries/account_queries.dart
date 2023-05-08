class AccountQueries {

   static const String listCustomerOpenBankingAccounts = r'''
     query listCustomerOpenBankingAccounts($customerId: UUID4!, $pagination: PaginationParams) {
       listCustomerOpenBankingAccounts(customerId: $customerId, pagination: $pagination) {
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
           code
           countryCode
           countryCodes
           displayName
           iconLogo
           id
           logo
           name
           primaryColor
           resources
           status
           textLogo
           type
           website
         }
         internalIdentification
         lastAccessedAt
         link {
           id
           status
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
     }
 ''';

 static const String getOpenBankingAccount = r'''
     query getOpenBankingAccount($id: UUID4!) {
       getOpenBankingAccount(id: $id) {
        balance {
          available
          current
        }
        balanceType
        bankProductId
        category
        collectedAt
        createdAt
        creditData  {
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
          status
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
     }
 ''';

 static const String listSellerOpenBankingAccounts = r'''
    query listSellerOpenBankingAccounts($pagination: PaginationParams, $sellerId: UUID4!) {
      listSellerOpenBankingAccounts(pagination: $pagination, sellerId: $sellerId) {
        balance {
          available
          current
        }
        balanceType
        bankProductId
        category
        collectedAt
        createdAt
        creditData  {
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
    }
''';


}