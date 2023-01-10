import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

abstract class CreateInvestmentState {}

class CreateInvestmentStateLoading extends CreateInvestmentState {}

class CreateInvestmentStateEmpty extends CreateInvestmentState {
  final UserModel userModel;  
  final List<InvestmentModel> wallets;

  CreateInvestmentStateEmpty({
    required this.userModel,
    required this.wallets,
  });
}

class CreateInvestmentStateError extends CreateInvestmentState {
  final Object erro;
CreateInvestmentStateError({required this.erro});

  @override
  String toString() => 'CreateInvestmentStateError(erro: $erro)';

}