// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

abstract class LoginState {
  Widget when({
    required Function(LoginStateEmpty) onEmpty,
    required Function(LoginStateLoading) onLoading,
    required Function(LoginStateSuccess) onSuccess,
    required Function(LoginStateError) onError,
  }) {
    switch (runtimeType) {
      case LoginStateEmpty:
        return onEmpty(this as LoginStateEmpty);
      case LoginStateLoading:
        return onLoading(this as LoginStateLoading);
      case LoginStateSuccess:
        return onSuccess(this as LoginStateSuccess);
      case LoginStateError:
        return onError(this as LoginStateError);
      default:
        return onEmpty(this as LoginStateEmpty);
    }
  }
}

class LoginStateEmpty extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {
  String user;
  LoginStateSuccess({
    required this.user,
  });
}

class LoginStateError extends LoginState {
  final Object erro;

  LoginStateError({required this.erro});

  @override
  String toString() => 'LoginStateError(erro: $erro)';
}
