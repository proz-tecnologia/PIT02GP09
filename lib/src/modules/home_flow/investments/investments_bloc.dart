import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<OnInvestmentsPageEmpty>(getUserData);
    on<OnInvestmentsPageSuccess>(getUserData);
  }

  Future<void> getUserData(
    InvestmentsPageEvent event,
    Emitter<InvestmentsPageState> emitter) async {
    try {
      emitter(InvestmentsPageStateLoading());
      final userModel = await repository.getUserData(userID: id!);
      List<InvestmentModel>? investments = [];
      log(investments.runtimeType.toString());
      investments = await repository.getInvestments(userID: id!);     

      if (investments!.isNotEmpty) {
        emitter(InvestmentsPageStateSuccess(user: userModel,
                                             investments: investments));
      } else {
        emitter(InvestmentsPageStateEmpty());
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(InvestmentsPageStateError(erro: e));
    }
  }

}