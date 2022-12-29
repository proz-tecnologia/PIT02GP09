import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

abstract class HomeState {}

class HomeStateEmpty extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateSuccess extends HomeState {
  final UserModel user;
  
  HomeStateSuccess({
    required this.user,
  });
  
}

class HomeStateError extends HomeState {
  final Object erro;

  HomeStateError({required this.erro});

  @override
  String toString() => 'HomeStateError(erro: $erro)';
}
