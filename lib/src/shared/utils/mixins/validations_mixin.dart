//Validar formulário
import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_model.dart';

mixin ValidationMixin {
  //Verifica se o input não está vazio
  String? isEmpty(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return message ?? "Este campo é obrigatório";
    }
    return null;
  }

  //Verifica o requisito minímo de caracteres
  String? hasXChars(String? value, [String? message, int quantidade = 5]) {
    if (value!.length < quantidade) {
      return message ?? "Deve conter $quantidade caracteres ou mais!";
    }
    return null;
  }

  //Combina uma lista de funções de validações
  //Combina diferentes regras de validações
  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}

String? validatePassword(password) {
  if (password == null || password.isEmpty) {
    return 'Preencha a senha';
  } else if (password.length < 6) {
    return 'A senha deve conter no mínimo 6 caracteres!';
  }

  String hasUppercase =
      password.contains(RegExp(r'[A-Z]')) ? '' : 'letras maiúsculas,';

  String hasDigits = password.contains(RegExp(r'[0-9]')) ? '' : 'números,';

  String hasLowercase =
      password.contains(RegExp(r'[a-z]')) ? '' : 'letras minúsculas,';

  String hasSpecialCharacters =
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
          ? ''
          : 'caractere especial,';
  String? result = '$hasUppercase$hasDigits$hasLowercase$hasSpecialCharacters';

  result = (result.isNotEmpty) ? "Deve conter: $result" : null;

  return result;
}

String? validateMail(String? value) {
  String regex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(regex);

  if (value == null || value.isEmpty) {
    return 'Preencha o e-mail';
  } else if (!regExp.hasMatch(value)) {
    return 'E-mail não é válido!';
  }
  return null;
}

String? enterValue(String? value, name) {
  if (value == null || value.isEmpty) {
    return 'Preencha $name';
  }

  return null;
}

String? preenchaTelefone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Preencha o telefone';
  }
  return null;
}

String? validaCpf(String? value) {
  if (value == null || value.isEmpty) {
    return 'Preencha o cpf';
  }
  if (!CPFValidator.isValid(value)) {
    return 'CPF inválido!';
  }
  return null;
}

String? validateConfPassword(String? value, String? password) {
  if (value == null || value.isEmpty) {
    return 'Confirme a senha!';
  }
  if (password != value) {
    return 'Senha diferentes!';
  }
  return null;
}

///Exemplo de uso - é aplicado atraves de "with" na classe state
///class nomeClaseState extends clsseState<> with nomeDoMixin{...}
///Exemplo de uso no widget
///validator:isNotEmpty[PADÃO] ou (value)=>isNotEmpty(value,message)
///Pode ser criado uma classe de constantes de messagens
///Exemplo de conbine
/* validator: (value)=> combine([
  ()=> isNotEmpty(value)
  ()=> hasXChars(value,message,quantidade)
]) */
//Fonte:https://youtu.be/HgFstMmYLok

Future<LoginModel?> validEmailSharedPref({
  required String mail,
  required String sharedPreferencesKeys,
}) async {
  List<LoginModel> usersAll = <LoginModel>[];
  LoginModel user;

  late final SharedPreferences sharedPrefers;
  sharedPrefers = await SharedPreferences.getInstance();

  final users = sharedPrefers.getString(sharedPreferencesKeys);

  if (users != null && users.isNotEmpty) {
    final usersDecode = jsonDecode(users);

    final decodedUsers =
        (usersDecode as List).map((e) => LoginModel.fromJson(e)).toList();
    usersAll.addAll(decodedUsers);
    for (var i = 0; i < usersAll.length; i++) {
      if (mail.trim().contains(usersAll[i].email.trim())) {
        user = LoginModel(
            name: usersAll[i].name,
            email: usersAll[i].email,
            password: usersAll[i].password);
        return user;
      }
    }
  }
  return null;
}
