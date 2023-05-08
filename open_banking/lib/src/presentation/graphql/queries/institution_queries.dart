class InstitutionQueries {

  static const String listOpenBankingInstitutions = r'''
     query{
       listOpenBankingInstitutions{
         code
         name
         displayName
         countryCode
         countryCodes
         iconLogo
         id
         logo
         primaryColor
         resources
         status
         textLogo
         type
         website
       }
     }
  ''';

}