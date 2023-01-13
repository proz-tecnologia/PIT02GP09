import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/plannings/planning_model.dart';
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
    UserModel userData = UserModel.fromMap(document);

    //final transactions = await getTransactions(userID: userID);
    //final balance = updateBalance(transactions: transactions);
    //final newUserData = userData.copyWith(balance: balance);
    return userData;
  }

  double updateBalance({required List<FinancialTransaction>? transactions}) {
    double balance = 0;
    if (transactions != null) {
      for (int i=0; i < transactions.length; i++) {
        if (transactions[i].type == TransactionTypes.receive) {
          balance += transactions[i].value;
        } else {
          balance -= transactions[i].value;
        }
      }
    }    
    return balance;
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

  @override
  Future<double> getMonthPlanning({
    required String userID,
    required int currentMonth}) async {
    
    final firstMonthDay= Timestamp.fromDate(DateTime(DateTime.now().year, currentMonth, 1));
    final lastMonthDay = Timestamp.fromDate(DateTime(DateTime.now().year, currentMonth + 1, 0));
    log(firstMonthDay.toString());
    log(lastMonthDay.toString());

    final firebaseMonthPlannings = 
    _firestore
    .collection('plannings')
    .where('userID', isEqualTo: userID)
    .where('finalDate', isGreaterThanOrEqualTo: firstMonthDay)
    .where('finalDate', isLessThanOrEqualTo: lastMonthDay);
    //..orderBy('date', descending: true);
    //..get();

    final filteredPlannings = await firebaseMonthPlannings.get();

    final plannings = 
    filteredPlannings.docs
    .map(
      (e) => PlanningModel.fromMap(
        Map<String, dynamic>.from(
          e.data(),
        ),
      ),
    ).toList();
    log(plannings.length.toString());

    double monthPlanningValue = 0;
    for (int i = 0; i < plannings.length; i++) {
      monthPlanningValue += plannings[i].value;
    }
    log(monthPlanningValue.toString());

    return monthPlanningValue;
    
    }
  
}