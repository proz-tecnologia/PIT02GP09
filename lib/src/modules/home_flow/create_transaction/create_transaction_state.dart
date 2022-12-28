
abstract class CreateTransactionState {}

class CreateTransactionStateLoading extends CreateTransactionState {}

class CreateTransactionStateSuccess extends CreateTransactionState {}

class CreateTransactionStateBankSlip extends CreateTransactionState {}

class CreateTransactionStateCreditCardPayment extends CreateTransactionState {}

class CreateTransactionStateGenericExpense extends CreateTransactionState {}

class CreateTransactionStateGenericReceive extends CreateTransactionState {}

class CreateTransactionError extends CreateTransactionState {
  final Object erro;

  CreateTransactionError({required this.erro});

  @override
  String toString() => 'CreateTransactionStateError(erro: $erro)';

}