
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

abstract class CreateTransactionState {}

class CreateTransactionStateLoading extends CreateTransactionState {}

class CreateTransactionStateEmpty extends CreateTransactionState {}

class CreateTransactionStateSuccess extends CreateTransactionState {
  final UserModel userModel;

  CreateTransactionStateSuccess({required this.userModel});
}

class CreateTransactionError extends CreateTransactionState {
  final Object erro;

  CreateTransactionError({required this.erro});

  @override
  String toString() => 'CreateTransactionStateError(erro: $erro)';

}