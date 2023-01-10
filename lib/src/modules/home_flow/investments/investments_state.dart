import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

abstract class InvestmentsPageState {}

class InvestmentsPageStateLoading extends InvestmentsPageState {}

class InvestmentsPageStateEmpty extends InvestmentsPageState {}

class InvestmentsPageStateSuccess extends InvestmentsPageState {
  final UserModel user;
  final List<InvestmentModel>? investments;
  
  InvestmentsPageStateSuccess({
    required this.user,
    required this.investments,
  });
}

class InvestmentsPageStateError extends InvestmentsPageState {
  final Object erro;

  InvestmentsPageStateError({required this.erro});

  @override
  String toString() => 'CreateTransactionStateError(erro: $erro)';
}