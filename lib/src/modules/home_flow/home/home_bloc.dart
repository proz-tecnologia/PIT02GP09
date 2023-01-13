// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/months/month_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomePageRepository repository;
  int currentMonth;
  double? currentValue;
  double? monthPlanningValue;
  double? planning;

  final String? id;
  UserModel? userModel;

  HomeBloc(
    {required this.repository,
    required this.currentMonth,
     required this.id,
     this.userModel,}
  ) : super(HomeStateEmpty()) {
    log('homebloc created');
    on<OnHomePageEmpty>(getUserData);
    on<OnHomePageLogout>(logout);
  }

  Future<void> logout(HomeEvent event, Emitter<HomeState> emitter) async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> getUserData(
    HomeEvent event,
    Emitter<HomeState> emitter) async {
    try {
      emitter(HomeStateLoading());
      userModel = await repository.getUserData(userID: id!);
      log('balanco 1: ${userModel!.balance.toString()}');

      // progbar data -------------------------------------------------------    
      monthPlanningValue =
        await repository.getMonthPlanning(
                userID: id!, 
                currentMonth: currentMonth);
      log('current month: ${currentMonth.toString()}');
      
      currentValue = 0;
      if (//userModel.balance != null &&
          userModel!.balance != 0) {
        currentValue = userModel!.balance;
      } else if (monthPlanningValue == 0) {
        currentValue = 100;
      }
      
        log('balance: ${userModel!.balance.toString()}');
        log('currentValue: ${currentValue.toString()}');

      planning = currentValue;

      if (monthPlanningValue != 0) {
        planning = monthPlanningValue;
      }

      log(monthPlanningValue.toString());
      log(planning.toString());

      log('balanco: ${userModel!.balance.toString()}');

      emitter(HomeStateSuccess(user: userModel!));

    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(HomeStateError(erro: e));
    }
  }

  // month container data -----------------------------------------------
  final double monthContainerHeight = 15.0;
  
  final List<Month> months = [ Month(monthName: 'janeiro'),
                                      Month(monthName: 'fevereiro'),
                                      Month(monthName: 'março'),
                                      Month(monthName: 'abril'),
                                      Month(monthName: 'maio'),
                                      Month(monthName: 'junho'),
                                      Month(monthName: 'julho'),
                                      Month(monthName: 'agosto'),
                                      Month(monthName: 'setembro'),
                                      Month(monthName: 'outubro'),
                                      Month(monthName: 'novembro'),
                                      Month(monthName: 'dezembro'),
                                ];



  void setMonth (
    {required int newMonth}
    ) {
    currentMonth = newMonth;
    log(currentMonth.toString());
  }

}
