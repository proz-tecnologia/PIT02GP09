import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';

abstract class InvestmentsPageEvent {
  
  final InvestmentModel? investment;

  InvestmentsPageEvent({
    this.investment,
  });
}

class OnInvestmentsInitState extends InvestmentsPageEvent {}
class OnInvestmentsDelete extends InvestmentsPageEvent {

  OnInvestmentsDelete({super.investment});
}
