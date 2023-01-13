import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

class CreateInvestmentBloc extends Bloc<CreateInvestmentEvent, CreateInvestmentState> {

  final CreateInvestmentRepository repository;
  final String? id;
  UserModel userModel;
  
  CreateInvestmentBloc({
    required this.repository,
    required this.id,
    required this.userModel,
  }) : super(CreateInvestmentStateLoading()) {
    log('Create investment bloc created');
    on<OnCreateInvestmentInitState>(getUserData);
    on<OnNewInvestment>(createInvestment);
  }

  Future<void> getUserData(
    CreateInvestmentEvent event,
    Emitter<CreateInvestmentState> emitter) async {
    try {
      emitter(CreateInvestmentStateLoading());
      final userModel = await repository.getUserData(userID: id!);
      emitter(CreateInvestmentStateEmpty(userModel: userModel));
      
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(CreateInvestmentStateError(erro: e));
    }
  }

  Future<void> createInvestment(    
    CreateInvestmentEvent event, 
    Emitter<CreateInvestmentState> emitter 
  ) async {
    log('funcao createInvestment chamada');
    try {
      emitter(CreateInvestmentStateLoading());
      
      final investment = event.newInvestment;
      final updatedInvestment = investment!.copyWith(userID: id);      

      await repository.createInvestment(investment: updatedInvestment);
        
      await updatePages();
          
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(CreateInvestmentStateError(erro: e));
    }
  }

  Future<void> updatePages() async {
    Modular.get<InvestmentsBloc>().add(OnInvestmentsInitState());
  }


}