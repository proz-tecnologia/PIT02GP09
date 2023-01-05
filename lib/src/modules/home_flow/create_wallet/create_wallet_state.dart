import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

abstract class CreateWalletState {}

class CreateWalletStateLoading extends CreateWalletState {}

class CreateWalletStateEmpty extends CreateWalletState {}

class CreateWalletStateSuccess extends CreateWalletState {
  final UserModel userModel;

  CreateWalletStateSuccess({required this.userModel});
}

class CreateWalletStateError extends CreateWalletState {
  final Object erro;

  CreateWalletStateError({required this.erro});

  @override
  String toString() => 'CreateWalletStateError(erro: $erro)';

}