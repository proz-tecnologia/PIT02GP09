import 'package:flutter/material.dart';

import '../../../shared/models/user_model.dart';

abstract class SignUpState {
  Widget when({
    required Widget Function(SignUpStateEmpty) onEmpty,
    required Widget Function(SignUpStateLoading) onLoading,
    required Function(SignUpStateSuccess) onSuccess,
    required Widget Function(SignUpStateError) onError,
  }) {
    switch (runtimeType) {
      case SignUpStateEmpty:
        return onEmpty(this as SignUpStateEmpty);
      case SignUpStateLoading:
        return onLoading(this as SignUpStateLoading);
      case SignUpStateSuccess:
        return onSuccess(this as SignUpStateSuccess);
      case SignUpStateError:
        return onError(this as SignUpStateError);
      default:
        return onEmpty(this as SignUpStateEmpty);
    }
  }
}

class SignUpStateEmpty extends SignUpState {}

class SignUpStateLoading extends SignUpState {}

class SignUpStateSuccess extends SignUpState {
  List<UserModel> user;
  SignUpStateSuccess({
    required this.user,
  });
}

class SignUpStateError extends SignUpState {
  final Object erro;

  SignUpStateError({required this.erro});
}
