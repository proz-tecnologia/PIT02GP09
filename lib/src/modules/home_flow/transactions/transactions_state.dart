
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

abstract class TransactionsPageState {}

class TransactionsPageStateLoading extends TransactionsPageState {}

class TransactionsPageStateEmpty extends TransactionsPageState {}

class TransactionsPageStateSuccess extends TransactionsPageState {
  final UserModel user;
  final List<FinancialTransaction>? transactions;
  
  TransactionsPageStateSuccess({
    required this.user,
    required this.transactions,
  });
}

class TransactionsPageStateError extends TransactionsPageState {
  final Object erro;

  TransactionsPageStateError({required this.erro});

  @override
  String toString() => 'CreateTransactionStateError(erro: $erro)';

}