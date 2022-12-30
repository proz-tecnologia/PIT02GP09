import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsPageRepositoryImpl implements TransactionsPageRepository {

  @override
  List<FinancialTransaction>? transactions;

  @override
  final SharedPreferences sharedPreferences;

  TransactionsPageRepositoryImpl({required this.sharedPreferences});

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  @override
  Future<UserModel> getUserData({required String userID}) async {
    log(userID);
    final response = await FirebaseFirestore.instance
    .collection('users')
    .where('userModelID', isEqualTo: userID)
    .get();
    final document = response.docs.first.data();   
    final userData = UserModel.fromMap(document);
    log(userData.userModelID);
    return userData;
  }

  @override
  Future<List<FinancialTransaction>?> getTransactions({required String userID}) async {
    final firebaseTransactions = 
    await _firestore
    .collection('transactions')
    .where('userID', isEqualTo: userID)
    .orderBy('date', descending: true)
    .get();

    transactions = firebaseTransactions.docs.map((e) => FinancialTransaction.fromMap(e.data())).toList();
    return transactions;
  }
}