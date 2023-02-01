import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

class InvestmentsBloc extends Bloc<InvestmentsPageEvent, InvestmentsPageState> {

  final InvestmentsRepository repository;
  final String? id;
  UserModel? userModel;

  InvestmentsBloc(
    {required this.repository,
     required this.id,
     this.userModel,}
  ) : super(InvestmentsPageStateEmpty()) {
    log('transactions page bloc created');
    on<OnInvestmentsInitState>(getUserData);
    on<OnInvestmentsDelete>(deleteInvestment);
  }

  Future<void> getUserData(
    InvestmentsPageEvent event,
    Emitter<InvestmentsPageState> emitter) async {
      
    try {
      emitter(InvestmentsPageStateLoading());
      final userModel = await repository.getUserData(userID: id!);
      List<InvestmentModel>? investments = [];
      investments = await repository.getInvestments(userID: id!);
      log(investments!.length.toString());

      if (investments.isNotEmpty) {
        log('investments is not empty');
        emitter(InvestmentsPageStateSuccess(user: userModel,
                                            investments: investments));
      } else {
        log('investments is empty');
        emitter(InvestmentsPageStateEmpty());
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(InvestmentsPageStateError(erro: e));
    }
  }

  Future<void> deleteInvestment(
    InvestmentsPageEvent event,
    Emitter<InvestmentsPageState> emitter
    ) async {
      log('funcao deleteInvestment chamada');
      try {
        emitter(InvestmentsPageStateLoading());

        final investmentDocID = event.investment!.id;
        await repository.deleteInvestment(docID: investmentDocID!);

        await updatePages();
        
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError(e, s);
        emitter(InvestmentsPageStateError(erro: e));
      }
    }

    Future<void> updatePages() async {
    Modular.get<InvestmentsBloc>().add(OnInvestmentsInitState());
  }

}