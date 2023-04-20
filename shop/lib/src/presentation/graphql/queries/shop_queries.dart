class ShopQueries {
  static const String listStores = r'''
        query listStores($filters: SearchableFieldsStore, $pagination: PaginationParams) {
          listStores(filters: $filters, pagination: $pagination) {   
            averageTime
            callNumber
            deliveryOptions {
              range
              rate
              rateString
              time
            }
            description
            displayName
            fee
            id
            isVisible
            logo
            mainSegment
            openingHours
            outOfHours
            pointOfSale {
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
            relevance
            storeBrand {
              id
              logo
              name
            }
            storeCategory {
              id
              name
            }
            storeMall {
              id
              name
              shortName
            }
            storePreferences {
              allowInstallment
              allowMethods
              defaultMaxInstallments
              defaultPaymentMethods
              eatIn
              serviceCharge
              takeOut
              usingDelivery
            }
            tags {
              name
            }
            themeColors
            whatsappConfirmedAt
            whatsappNumber
          }
        }
      ''';

  static const String listStoreBrands = r'''
        query listStoreBrands($filters: SearchableFieldsStoreBrand, $pagination: PaginationParams) {
          listStoreBrands(filters: $filters, pagination: $pagination) {
            id
            logo
            name
          }
        }
      ''';

  static const String listStoreMalls = r'''
        query listStoreMalls {
          listStoreMalls {
            id
            name
            shortName
          }
        }
      ''';
}
