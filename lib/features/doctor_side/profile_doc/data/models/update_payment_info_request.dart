class UpdatePaymentInfoRequest {
  final String accountHolderName;
  final String accountNumber;
  final String bankName;
  final String iban;
  final String transferPeriod;

  const UpdatePaymentInfoRequest({
    required this.accountHolderName,
    required this.accountNumber,
    required this.bankName,
    required this.iban,
    required this.transferPeriod,
  });

  Map<String, dynamic> toJson() {
    return {
      "accountHolderName": accountHolderName,
      "accountNumber": accountNumber,
      "bankName": bankName,
      "iban": iban,
      "transferPeriod": transferPeriod,
    };
  }
}
