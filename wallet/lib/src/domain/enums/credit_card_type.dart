enum CreditCardType { mastercard, elo, visa, americanExpress }

extension CreditCardTypeExt on CreditCardType {
  String get image {
    switch (this) {
      case CreditCardType.mastercard:
        return 'assets/logos/mastercard.png';
      case CreditCardType.elo:
        return 'assets/logos/elo.png';
      case CreditCardType.visa:
        return 'assets/logos/visa.png';
      case CreditCardType.americanExpress:
        return 'assets/logos/amex.png';
    }
  }

  String get toJson {
    switch (this) {
      case CreditCardType.mastercard:
        return 'mastercard';
      case CreditCardType.elo:
        return 'elo';
      case CreditCardType.visa:
        return 'visa';
      case CreditCardType.americanExpress:
        return 'americanExpress';
    }
  }
}

CreditCardType creditCardTypeFromJson(String? type) {
  switch (type) {
    case 'mastercard':
      return CreditCardType.mastercard;
    case 'elo':
      return CreditCardType.elo;
    case 'visa':
      return CreditCardType.visa;
    case 'americanExpress':
      return CreditCardType.americanExpress;
    default:
      return CreditCardType.visa;
  }
}
