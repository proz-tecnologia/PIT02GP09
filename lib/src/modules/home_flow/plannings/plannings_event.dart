import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/plannings/planning_model.dart';

abstract class PlanningsPageEvent {

  final PlanningModel? planning;
  
  PlanningsPageEvent({
    this.planning,
  }); 
}

class OnPlanningsInitState extends PlanningsPageEvent {}
class OnPlanningsDelete extends PlanningsPageEvent {

  OnPlanningsDelete({super.planning});
}