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
  Future<List<FinancialTransaction>?> getTransactions({
    required String userID,
    List<String>? categories}) async {

      final firebaseTransactions;

      if (categories != null) {
        firebaseTransactions = 
        _firestore
        .collection('transactions')
        .where('userID', isEqualTo: userID)   
        .where('category', whereIn: categories);
      } else {
        firebaseTransactions = 
        _firestore
        .collection('transactions')
        .where('userID', isEqualTo: userID);
      }
    
    //..get();

    final filteredTransactions = await firebaseTransactions.orderBy('date', descending: true).get();

    // O ERRO ESTÁ ABAIXO

    final transactions = 
    (filteredTransactions.docs as List)
    .map(
      (e) => FinancialTransaction.fromMap(
        Map<String, dynamic>.from(
          e.data() as Map<String, dynamic>,
        ),
      ),
    ).toList();
    log(transactions.runtimeType.toString());
    log(transactions.toString());
    return transactions;
  }
}