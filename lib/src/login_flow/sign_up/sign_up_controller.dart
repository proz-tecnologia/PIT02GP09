import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/shared_preferences_keys.dart';
import '../../models/user_model.dart';
import 'sign_up_state.dart';

class SignUpController {
  SignUpState state = SignUpStateEmpty();
  final VoidCallback onUpdate;

  List<UserModel> newUsers = <UserModel>[];

  late final SharedPreferences sharedPrefers;

  SignUpController({
    required this.onUpdate,
  }) {
    init();
  }

  Future<bool> logout() async {
    late final SharedPreferences sharedPrefers;
    sharedPrefers = await SharedPreferences.getInstance();
    return await sharedPrefers.remove(SharedPreferencesKeys.userSession);
  }

  void updateState(SignUpState newState) {
    state = newState;
    onUpdate();
  }

  Future<void> init() async {
    updateState(SignUpStateLoading());
    sharedPrefers = await SharedPreferences.getInstance();

    final users = sharedPrefers.getString(SharedPreferencesKeys.users);

    if (users != null && users.isNotEmpty) {
      final usersDecode = jsonDecode(users);

      final decodedUsers =
          (usersDecode as List).map((e) => UserModel.fromJson(e)).toList();
      newUsers.addAll(decodedUsers);

      updateState(SignUpStateSuccess());
    } else {
      updateState(SignUpStateEmpty());
    }
  }

  Future<void> addUser({required UserModel user}) async {
    updateState(SignUpStateLoading());
    await Future.delayed(const Duration(seconds: 3));
    print("teste");
    newUsers.add(user);

    final newUsersJson = newUsers.map((e) => e.toJson()).toList();

    sharedPrefers.setString(
        SharedPreferencesKeys.users, jsonEncode(newUsersJson));

    updateState(SignUpStateSuccess());
  }
}
