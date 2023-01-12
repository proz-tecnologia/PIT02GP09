import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

abstract class CreatePlanningState {}

class CreatePlanningStateLoading extends CreatePlanningState {}

class CreatePlanningStateEmpty extends CreatePlanningState {
  final UserModel userModel;

  CreatePlanningStateEmpty({required this.userModel});
}

class CreatePlanningStateError extends CreatePlanningState {
  final Object erro;
CreatePlanningStateError({required this.erro});

  @override
  String toString() => 'CreatePlanningStateError(erro: $erro)';

}