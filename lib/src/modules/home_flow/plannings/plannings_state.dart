
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/plannings/planning_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

abstract class PlanningsState {}

class PlanningsStateLoading extends PlanningsState {}

class PlanningsStateEmpty extends PlanningsState {}

class PlanningsStateSuccess extends PlanningsState {
  final UserModel user;
  final List<PlanningModel>? plannings;
  
  PlanningsStateSuccess({
    required this.user,
    required this.plannings,
  });
}

class PlanningsStateError extends PlanningsState {
  final Object erro;

  PlanningsStateError({required this.erro});

  @override
  String toString() => 'PlanningsStateError(erro: $erro)';

}