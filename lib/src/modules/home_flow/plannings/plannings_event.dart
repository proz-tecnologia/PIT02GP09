abstract class PlanningsPageEvent {  
  final List<String>? plannings;
  
  PlanningsPageEvent({
    this.plannings,
  }); 
}

class OnPlanningsInitState extends PlanningsPageEvent {}