import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageRepositoryImpl implements HomePageRepository {

  @override
  final SharedPreferences sharedPreferences;
  List<FinancialTransaction>? transactions;

  HomePageRepositoryImpl({required this.sharedPreferences});

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
  Future<List<FinancialTransaction>?> getTransactions({
    required String userID,
    List<String>? categories}) async {
    final firebaseTransactions = 
    _firestore
    .collection('transactions')
    ..where('userID', isEqualTo: userID)
    ..orderBy('date', descending: true);
    //..get();

    if (categories?.isNotEmpty ?? false) {
      firebaseTransactions.where('category', whereIn: categories);
    }

    final filteredTransactions = await firebaseTransactions.get();

    transactions = filteredTransactions.docs
    .map(
      (e) => FinancialTransaction.fromMap(
      e.data()))
      .toList();
    return transactions;
  }
  
}