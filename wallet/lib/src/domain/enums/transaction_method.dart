enum TransactionMethod {
  pix,
  moneyExternal,
  debitExternal,
  creditCard,
  bankSlip,
  wallet,
}

extension TransactionMethodExt on TransactionMethod {
  String get name {
    switch (this) {
      case TransactionMethod.pix:
        return 'Pix';
      case TransactionMethod.moneyExternal:
        return 'Débito';
      case TransactionMethod.debitExternal:
        return 'Débito';
      case TransactionMethod.creditCard:
        return 'Crédito';
      case TransactionMethod.bankSlip:
        return 'Boleto bancário';
      case TransactionMethod.wallet:
        return 'Carteira';
    }
  }

  String get toJson {
    switch (this) {
      case TransactionMethod.pix:
        return 'PIX';
      case TransactionMethod.moneyExternal:
        return 'MONEY_EXTERNAL';
      case TransactionMethod.debitExternal:
        return 'DEBIT_EXTERNAL';
      case TransactionMethod.creditCard:
        return 'CREDIT_CARD';
      case TransactionMethod.bankSlip:
        return 'BANK_SLIP';
      case TransactionMethod.wallet:
        return 'WALLET';
    }
  }
}

TransactionMethod transactionMethodFromJson(String? type) {
  switch (type) {
    case 'PIX':
      return TransactionMethod.pix;
    case 'MONEY_EXTERNAL':
      return TransactionMethod.moneyExternal;
    case 'DEBIT_EXTERNAL':
      return TransactionMethod.debitExternal;
    case 'CREDIT_CARD':
      return TransactionMethod.creditCard;
    case 'BANK_SLIP':
      return TransactionMethod.bankSlip;
    case 'WALLET':
      return TransactionMethod.wallet;
    default:
      return TransactionMethod.wallet;
  }
}
