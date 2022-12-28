
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTransactionRepositoryImpl implements CreateTransactionRepository {

  @override
  final SharedPreferences sharedPreferences;
  
  CreateTransactionRepositoryImpl({required this.sharedPreferences});

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  @override
  Future<void> createTransaction({required FinancialTransaction transaction}) async {

    // cria transacao e automaticamente gera um id
    final response = await _firestore
    .collection('transactions')
    .add(transaction.toMap());

    // update na transacao criada anteriormente adicionando o id gerado na criacao
    await _firestore
    .collection('transactions')
    .doc(response.id)
    .update({'id' : response.id});

    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> updateBalance({required UserModel userModel}) async {
    log(userModel.balance.toString());
    log(userModel.userModelDocID.toString());
    // update apenas do parametro 'balance' do usuario no Firebase
    await _firestore
    .collection('users')
    .doc(userModel.userModelDocID)
    .update({'balance' : userModel.balance});
    
  }

  

}