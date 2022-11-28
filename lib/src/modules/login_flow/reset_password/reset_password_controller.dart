// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../../../utils/shared_preferences_keys.dart';
import 'reset_password_state.dart';

class ResetPasswordController {
  final VoidCallback onUpdate;
  ResetPasswordState state = ResetPasswordStateEmpty();

  late UserModel user;
  List<UserModel> users = <UserModel>[];

  ResetPasswordController({
    required this.onUpdate,
  }) {
    init();
  }

  void updateState(ResetPasswordState newState) {
    state = newState;
    onUpdate();
  }

  Future<void> init() async {
    updateState(ResetPasswordStateLoading());
    late final SharedPreferences sharedPrefers;
    sharedPrefers = await SharedPreferences.getInstance();

    final usersShared = sharedPrefers.getString(SharedPreferencesKeys.users);

    if (usersShared != null && usersShared.isNotEmpty) {
      final usersDecode = jsonDecode(usersShared);

      final decodedUsers =
          (usersDecode as List).map((e) => UserModel.fromJson(e)).toList();
      users.addAll(decodedUsers);

      updateState(ResetPasswordStateSuccess());
    } else {
      updateState(ResetPasswordStateEmpty());
    }
  }

  Future<void> resetPassword({required UserModel user}) async {
    updateState(ResetPasswordStateLoading());
    late final SharedPreferences sharedPrefers;
    sharedPrefers = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 3));


    for (var i = 0; i < users.length; i++) {
      if (users[i].email.trim() == user.email.trim()) {
        users[i] = user;
      }
    }

    final newUsersJson = users.map((e) => e.toJson()).toList();
    sharedPrefers.setString(
        SharedPreferencesKeys.users, jsonEncode(newUsersJson));

    updateState(ResetPasswordStateSuccess());
  }
}
