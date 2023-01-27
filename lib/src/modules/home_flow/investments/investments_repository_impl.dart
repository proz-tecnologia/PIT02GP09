import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvestmentsRepositoryImpl implements InvestmentsRepository {

  @override
  List<InvestmentModel>? investments;

  @override
  final SharedPreferences sharedPreferences;

  InvestmentsRepositoryImpl({required this.sharedPreferences});

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
  Future<List<InvestmentModel>?> getInvestments({required String userID}) async {

      var firebaseInvestments = 
        _firestore
        .collection('investments')
        .where('userID', isEqualTo: userID);

    final filteredInvestments = await firebaseInvestments.orderBy('initialDate', descending: true).get();

    final investments = 
    filteredInvestments.docs
    .map(
      (e) => InvestmentModel.fromMap(
        Map<String, dynamic>.from(
          e.data(),
        ),
      ),
    ).toList();
    return investments;
  }

  @override
  Future<void> deleteInvestment({required String docID}) async {

    await _firestore
    .collection('investments')
    .doc(docID)
    .delete();

  }
  
}