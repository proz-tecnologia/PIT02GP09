// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/app_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AppRepository repo;
  HomeBloc(
    {required this.repo}
  ) : super(HomeStateEmpty()) {
    on<OnHomePageEmpty>(empty);
  }

  empty(HomeEvent event, Emitter<HomeState> emitter) {
    emitter(HomeStateEmpty());
  }
}
