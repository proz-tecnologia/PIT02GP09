import 'package:flutter/material.dart';

abstract class ResetPasswordState {  Widget when({
    required Function(ResetPasswordStateEmpty) onEmpty,
    required Function(ResetPasswordStateLoading) onLoading,
    required Function(ResetPasswordStateSuccess) onSuccess,
    required Function(ResetPasswordStateError) onError,
  }) {
    switch (runtimeType) {
      case ResetPasswordStateEmpty:
        return onEmpty(this as ResetPasswordStateEmpty);
      case ResetPasswordStateLoading:
        return onLoading(this as ResetPasswordStateLoading);
      case ResetPasswordStateSuccess:
        return onSuccess(this as ResetPasswordStateSuccess);
      case ResetPasswordStateError:
        return onError(this as ResetPasswordStateError);
      default:
        return onEmpty(this as ResetPasswordStateEmpty);
    }
  }
}

class ResetPasswordStateEmpty extends ResetPasswordState {}

class ResetPasswordStateLoading extends ResetPasswordState {}

class ResetPasswordStateSuccess extends ResetPasswordState {}

class ResetPasswordStateError extends ResetPasswordState {
  final Object erro;

  ResetPasswordStateError({required this.erro});

  @override
  String toString() => 'ResetPasswordStateError(erro: $erro)';
}
