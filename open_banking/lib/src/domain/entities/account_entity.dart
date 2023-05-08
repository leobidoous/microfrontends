import 'account_institution_entity.dart';
import 'balance_entity.dart';
import 'credit_data_entity.dart';
import 'customer_entity.dart';
import 'gig_payment_data_entity.dart';
import 'link_entity.dart';
import 'loan_data_entity.dart';
import 'seller_entity.dart';

class AccountEntity {
  
  AccountEntity({
    required this.balance,
    required this.balanceType,
    required this.bankProductId,
    required this.category,
    required this.collectedAt,
    required this.createdAt,
    required this.creditData,
    required this.currency,
    required this.customer,
    required this.externalId,
    required this.gigPaymentData,
    required this.id,
    required this.institution,
    required this.internalIdentification,
    required this.lastAccessedAt,
    required this.link,
    required this.loanData,
    required this.name,
    required this.number,
    required this.publicIdentificationName,
    required this.publicIdentificationValue,
    required this.seller,
    required this.type,
  });

  final BalanceEntity balance;
  final String balanceType;
  final String bankProductId;
  final String category;
  final DateTime collectedAt;
  final DateTime createdAt;
  final CreditDataEntity creditData;
  final String currency;
  final CustomerEntity customer;
  final String externalId;
  final GigPaymentDataEntity gigPaymentData;
  final String id;
  final AccountInstitutionEntity institution;
  final String internalIdentification;
  final DateTime lastAccessedAt;
  final LinkEntity link;
  final LoanDataEntity loanData;
  final String name;
  final String number;
  final String publicIdentificationName;
  final String publicIdentificationValue;
  final SellerEntity seller;
  final String type;
}
