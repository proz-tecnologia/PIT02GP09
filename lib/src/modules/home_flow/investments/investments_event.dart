abstract class InvestmentsPageEvent {  
  final List<String>? investments;
  
  InvestmentsPageEvent({
    this.investments,
  }); 
}

class OnInvestmentsPageEmpty extends InvestmentsPageEvent {}

class OnInvestmentsPageSuccess extends InvestmentsPageEvent {
  OnInvestmentsPageSuccess({
    super.investments,
  }); 
}