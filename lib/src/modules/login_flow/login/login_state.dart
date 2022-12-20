// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

abstract class LoginState {}

class LoginStateEmpty extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {}

class LoginStateError extends LoginState {
  final Object erro;

  LoginStateError({required this.erro});

  @override
  String toString() => 'LoginStateError(erro: $erro)';
}
