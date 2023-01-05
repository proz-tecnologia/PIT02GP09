
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';

abstract class WalletsPageState {}

class WalletsPageStateLoading extends WalletsPageState {}

class WalletsPageStateEmpty extends WalletsPageState {}

class WalletsPageStateSuccess extends WalletsPageState {
  final UserModel user;
  final List<WalletModel>? wallets;
  
  WalletsPageStateSuccess({
    required this.user,
    required this.wallets,
  });
}

class WalletsPageStateError extends WalletsPageState {
  final Object erro;

  WalletsPageStateError({required this.erro});

  @override
  String toString() => 'WalletsPageStateError(erro: $erro)';

}