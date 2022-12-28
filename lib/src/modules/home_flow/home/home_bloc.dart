// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomePageRepository repository;
  final String? id;
  UserModel? userModel;

  HomeBloc(
    {required this.repository,
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

  Future<void> getUserData(HomeEvent event, Emitter<HomeState> emitter) async {
    try {
      emitter(HomeStateLoading());
      userModel= await repository.getUserData(userID: id!);
      emitter(HomeStateSuccess(user: userModel!));
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(HomeStateError(erro: e));
    }


  }

}
