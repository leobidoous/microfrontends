class AccessTokenMutationsDart {

  static const String generateOpenBankingAccessToken = r'''
      mutation generateOpenBankingAccessToken {
        generateOpenBankingAccessToken {
          access
          refresh       
        }
      }
  ''';

}