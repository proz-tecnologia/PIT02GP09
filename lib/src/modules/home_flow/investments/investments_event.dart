abstract class InvestmentsPageEvent {  
  final List<String>? investments;
  
  InvestmentsPageEvent({
    this.investments,
  }); 
}

class OnInvestmentsInitState extends InvestmentsPageEvent {}