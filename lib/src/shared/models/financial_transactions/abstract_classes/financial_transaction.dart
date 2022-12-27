
enum TransactionTypes {
  bankSlip,
  creditCardPayment,
  genericExpense,
  genericReceive,
}

abstract class FinancialTransaction {

  final TransactionTypes type;
  final String name;
  final double value;
  final DateTime date;
  final String? userID;
  final String? id;
  
  FinancialTransaction({
    required this.type,
    required this.name,
    required this.value,
    required this.date,
    this.userID,
    this.id,
  });

  static TransactionTypes? transactionTypesFromString(String transaction) {
    switch (transaction) {
      case 'TransactionTypes.bankSlip':
        return TransactionTypes.bankSlip;
      case 'TransactionTypes.creditCardPayment':
        return TransactionTypes.creditCardPayment;
      case 'TransactionTypes.genericExpense':
        return TransactionTypes.genericExpense;
      case 'TransactionTypes.genericReceive':
        return TransactionTypes.genericReceive;
      default:
        return null;
    }
  }

}