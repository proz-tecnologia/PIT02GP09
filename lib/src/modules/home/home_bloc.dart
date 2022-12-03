// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/repositories/repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Repository repo;
  HomeBloc(
    {required this.repo}
  ) : super(HomeStateEmpty()) {
    on<OnHomePageEmpty>(empty);
  }

  empty(HomeEvent event, Emitter<HomeState> emitter) {
    emitter(HomeStateEmpty());
  }
}
