// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/page_state.dart';

abstract class SignUpState extends PageState {}

class SignUpStateEmpty extends SignUpState {}

class SignUpStateLoading extends SignUpState {}

class SignUpStateSuccess extends SignUpState {}

class SignUpStateError extends SignUpState {
  final String erro;

  SignUpStateError({required this.erro});

  @override
  String toString() => 'SignUpStateError(erro: $erro)';
}
