import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';

abstract class TransactionsPageEvent { 

  final FinancialTransaction? transaction;
  final List<String>? categories;
  
  TransactionsPageEvent({
    this.categories,
    this.transaction,
  }); 
}

class OnTransactionsPageEmpty extends TransactionsPageEvent {}

class OnTransactionsInitState extends TransactionsPageEvent {
  OnTransactionsInitState({
    super.categories,
  });
}

class OnTransactionsDelete extends TransactionsPageEvent {

  OnTransactionsDelete({super.transaction});
}