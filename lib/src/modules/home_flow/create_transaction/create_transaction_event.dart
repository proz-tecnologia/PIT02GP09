import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';

abstract class CreateTransactionEvent {
  final FinancialTransaction? newTransaction;

  CreateTransactionEvent({
    this.newTransaction,
  });
}

class OnInitState extends CreateTransactionEvent {}

class OnNewTransaction extends CreateTransactionEvent {
  OnNewTransaction({required super.newTransaction});
}