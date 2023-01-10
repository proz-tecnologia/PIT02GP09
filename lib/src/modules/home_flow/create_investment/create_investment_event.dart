import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';

abstract class CreateInvestmentPageEvent {
  final InvestmentModel? newInvestment;

  CreateInvestmentPageEvent({
    this.newInvestment,
  });
}

class OnInitState extends CreateInvestmentPageEvent {}

class OnNewInvestment extends CreateInvestmentPageEvent {
  OnNewInvestment({required super.newInvestment});
}