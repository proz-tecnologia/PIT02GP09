// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/models/user_model.dart';
import '../../../shared/repositories/repository.dart';
import '../../../utils/shared_preferences_keys.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final SharedPreferences sharedPreferences;
  Repository repo;
  ResetPasswordBloc({
    required this.sharedPreferences,
    required this.repo,
  }) : super(ResetPasswordStateEmpty()) {
    initResetPasswordPressed();
    on<OnResetPasswordPressed>(resetPasswordPressed);
  }

  List<UserModel> users = <UserModel>[];

  Future<void> initResetPasswordPressed() async {
    final usersShared =
        sharedPreferences.getString(SharedPreferencesKeys.users);

    if (usersShared != null && usersShared.isNotEmpty) {
      final usersDecode = jsonDecode(usersShared);

      final decodedUsers =
          (usersDecode as List).map((e) => UserModel.fromJson(e)).toList();
      users.addAll(decodedUsers);
    }
  }

  Future<void> resetPasswordPressed(
      ResetPasswordEvent event, Emitter<ResetPasswordState> emitter) async {
    emitter(ResetPasswordStateLoading());
    await Future.delayed(const Duration(seconds: 3));

    for (var i = 0; i < users.length; i++) {
      if (users[i].email.trim() == event.user!.email.trim()) {
        users[i] = event.user!;
      }
    }

    final newUsersJson = users.map((e) => e.toJson()).toList();
    sharedPreferences.setString(
        SharedPreferencesKeys.users, jsonEncode(newUsersJson));

    emitter(ResetPasswordStateSuccess());
  }
}
