import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

class CreateInvestmentBloc extends Bloc<CreateInvestmentPageEvent, CreateInvestmentState> {

  final CreateInvestmentRepository repository;
  final String? id;
  UserModel userModel;
  
  CreateInvestmentBloc({
    required this.repository,
    required this.id,
    required this.userModel,
  }) : super(CreateInvestmentStateLoading()) {
    log('Create investment bloc created');
    //on<OnInitState>(getUserData);
    //on<OnNewTransaction>(createTransaction);
  }
}