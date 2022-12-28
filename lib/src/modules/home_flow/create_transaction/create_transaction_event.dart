
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';

abstract class CreateTransactionEvent {
  final FinancialTransaction? newTransaction;

  CreateTransactionEvent({
    required this.newTransaction,
  });
}

class OnNewTransaction extends CreateTransactionEvent {
  OnNewTransaction({required super.newTransaction});
}