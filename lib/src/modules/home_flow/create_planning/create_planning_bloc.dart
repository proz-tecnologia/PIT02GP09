import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

class CreatePlanningBloc extends Bloc<CreatePlanningEvent, CreatePlanningState> {

  final CreatePlanningRepository repository;
  final String? id;
  UserModel userModel;
  
  CreatePlanningBloc({
    required this.repository,
    required this.id,
    required this.userModel,
  }) : super(CreatePlanningStateLoading()) {
    log('Create planning bloc created');
    on<OnCreatePlanningInitState>(getUserData);
    on<OnNewPlanning>(createPlanning);
  }

  Future<void> getUserData(
    CreatePlanningEvent event,
    Emitter<CreatePlanningState> emitter) async {
    try {
      emitter(CreatePlanningStateLoading());
      final userModel = await repository.getUserData(userID: id!);
      emitter(CreatePlanningStateEmpty(userModel: userModel));
      
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(CreatePlanningStateError(erro: e));
    }
  }

  Future<void> createPlanning(    
    CreatePlanningEvent event, 
    Emitter<CreatePlanningState> emitter 
  ) async {
    log('funcao createPlanning chamada');
    try {
      emitter(CreatePlanningStateLoading());
      
      final planning = event.newPlanning;
      final updatedPlanning = planning!.copyWith(userID: id);      

      await repository.createPlanning(planning: updatedPlanning);
        
      await updatePages();

      emitter(CreatePlanningStateSuccess());
          
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(CreatePlanningStateError(erro: e));
    }
  }

  Future<void> updatePages() async {
    Modular.get<PlanningsBloc>().add(OnPlanningsInitState());
  }


}