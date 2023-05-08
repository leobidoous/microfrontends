import 'account_entity.dart';
import 'credit_data_entity.dart';
import 'transaction_merchant_entity.dart';

class TransactionEntity {
  
  TransactionEntity({
    required this.account,
    required this.accountingDate,
    required this.amount,
    required this.balance,
    required this.category,
    required this.collectedAt,
    required this.creditData,
    required this.currency,
    required this.description,
    required this.externalId,
    required this.id,
    required this.merchant,
    required this.observations,
    required this.reference,
    required this.status,
    required this.type,
    required this.valueDate,
  });

  final AccountEntity account;
  final DateTime accountingDate;
  final String amount;
  final String balance;
  final String category;
  final DateTime collectedAt;
  final CreditDataEntity creditData;
  final String currency;
  final String description;
  final String externalId;
  final String id;
  final TransactionMerchantEntity merchant;
  final String observations;
  final String reference;
  final String? status;
  final String type;
  final DateTime valueDate;

}
