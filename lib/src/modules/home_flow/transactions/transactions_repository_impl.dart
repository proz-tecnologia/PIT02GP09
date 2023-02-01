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

      log(categories.toString());

      var firebaseTransactions = 
        _firestore
        .collection('transactions')
        .where('userID', isEqualTo: userID);

      if (categories != null) {
        firebaseTransactions = 
        firebaseTransactions
        .where('category', whereIn: categories);
      }

    final filteredTransactions = await firebaseTransactions.orderBy('date', descending: true).get();
    log(filteredTransactions.toString());

    final transactions = 
    filteredTransactions.docs
    .map(
      (e) => FinancialTransaction.fromMap(
        Map<String, dynamic>.from(
          e.data(),
        ),
      ),
    ).toList();
    return transactions;
  }

  @override
  Future<void> deleteTransaction({required String docID}) async {

    await _firestore
    .collection('transactions')
    .doc(docID)
    .delete();

  }

  @override
  Future<void> updateWallet({required String walletID, required double value}) async {
    await _firestore
    .collection('wallets')
    .doc(walletID)
    .update({'value' : value});

  }

}