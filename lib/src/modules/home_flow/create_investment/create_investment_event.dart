import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';

abstract class CreateInvestmentEvent {
  final InvestmentModel? newInvestment;

  CreateInvestmentEvent({
    this.newInvestment,
  });
}

class OnCreateInvestmentInitState extends CreateInvestmentEvent {}

class OnNewInvestment extends CreateInvestmentEvent {
  OnNewInvestment({required super.newInvestment});
}