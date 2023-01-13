
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';

abstract class CreateTransactionState {}

class CreateTransactionStateLoading extends CreateTransactionState {}

class CreateTransactionStateNoWallets extends CreateTransactionState {}

class CreateTransactionStateEmpty extends CreateTransactionState {
  final UserModel userModel;  
  final List<WalletModel> wallets;

  CreateTransactionStateEmpty({
    required this.userModel,
    required this.wallets,
  });
}

class CreateTransactionError extends CreateTransactionState {
  final Object erro;

  CreateTransactionError({required this.erro});

  @override
  String toString() => 'CreateTransactionStateError(erro: $erro)';

}