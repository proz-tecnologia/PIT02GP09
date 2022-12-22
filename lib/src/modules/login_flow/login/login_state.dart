// ignore_for_file: public_member_api_docs, sort_constructors_first
//import 'package:flutter/material.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/page_state.dart';

abstract class LoginState extends PageState {}

class LoginStateEmpty extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {}

class LoginStateError extends LoginState {
  final Object erro;

  LoginStateError({required this.erro});

  @override
  String toString() => 'LoginStateError(erro: $erro)';
}
