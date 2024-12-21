part of 'enums.dart';

enum PayoutType { bankTransfer, paypal }

Map<int, PayoutType> payoutTypeMap = {
  0: PayoutType.bankTransfer,
  1: PayoutType.paypal,
};

Map<PayoutType, String> payoutTypeName = {
  PayoutType.bankTransfer: 'Add Cash',//'Bank Transfer',
  PayoutType.paypal: 'PayPal',
};
