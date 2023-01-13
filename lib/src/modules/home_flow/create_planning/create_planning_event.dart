import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/plannings/planning_model.dart';

abstract class CreatePlanningEvent {
  final PlanningModel? newPlanning;

  CreatePlanningEvent({
    this.newPlanning,
  });
}

class OnCreatePlanningInitState extends CreatePlanningEvent {}

class OnNewPlanning extends CreatePlanningEvent {
  OnNewPlanning({required super.newPlanning});
}