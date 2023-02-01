import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

class WalletsRepositoryImpl extends WalletsRepository {

  WalletsRepositoryImpl({required super.sharedPreferences});

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  @override
  Future<UserModel> getUserData({required String userID}) async {
    final response = await FirebaseFirestore.instance
    .collection('users')
    .where('userModelID', isEqualTo: userID)
    .get();
    final document = response.docs.first.data();   
    final userData = UserModel.fromMap(document);
    return userData;
  }

  @override
  Future<List<WalletModel>?> getWallets({required String userID}) async {

      var firebaseWallets = 
        _firestore
        .collection('wallets')
        .where('userID', isEqualTo: userID);

    final firebaseWalletsGet = await firebaseWallets.get();

    final wallets = 
    firebaseWalletsGet.docs
    .map(
      (e) => WalletModel.fromMap(
        Map<String, dynamic>.from(
          e.data(),
        ),
      ),
    ).toList();
    log(wallets.length.toString());
    return wallets;
  }

  @override
  Future<List<FinancialTransaction>?> getTransactions({
    required String userID, 
    required String walletID}) async {

      var firebaseTransactions = 
        _firestore
        .collection('transactions')
        .where('userID', isEqualTo: userID)
        .where('walletID', isEqualTo: walletID);
      
    final filteredTransactions = await firebaseTransactions.get();

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
  Future<void> deleteWallet({required String docID}) async {

    await _firestore
    .collection('wallets')
    .doc(docID)
    .delete();

  }  

  @override
  Future<void> deleteTransactions({required String walletID}) async {

    final firebaseTransactions =
    await _firestore
    .collection('transactions')
    .where('walletID', isEqualTo: walletID)
    .get();

    final transactions = 
    firebaseTransactions.docs
    .map(
      (e) => FinancialTransaction.fromMap(
        Map<String, dynamic>.from(
          e.data(),
        ),
      ),
    ).toList();

    for (int i=0; i < transactions.length; i++) {
      deleteTransaction(docID: transactions[i].id!);
    }
  }

  @override
  Future<void> deleteTransaction({required String docID}) async {
    await _firestore
    .collection('transactions')
    .doc(docID)
    .delete();
  }

  @override
  Future<void> updateBalance({required UserModel userModel}) async {
    // update apenas do parametro 'balance' do usuario no Firebase
    await _firestore
    .collection('users')
    .doc(userModel.userModelDocID)
    .update({'balance' : userModel.balance});    
  }

  @override
  Future<void> deleteCategory({
    required String category,
    required UserModel userModel,
    }) async {
    log(category);
    await _firestore
    .collection('users')
    .doc(userModel.userModelDocID)
    .update({'categories' : FieldValue.arrayRemove([category])});
  }

}