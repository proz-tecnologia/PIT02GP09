import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateInvestmentRepositoryImpl implements CreateInvestmentRepository {

  @override
  final SharedPreferences sharedPreferences;
  
  CreateInvestmentRepositoryImpl({required this.sharedPreferences});
  
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
  Future<void> createInvestment({required InvestmentModel investment}) async {

    // cria investimento e automaticamente gera um id
    final response = await _firestore
    .collection('investments')
    .add(investment.toMap());

    // update no investimento criado anteriormente adicionando o id gerado na criacao
    await _firestore
    .collection('investments')
    .doc(response.id)
    .update({'id' : response.id});

    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<List<InvestmentModel>> getInvestments({required String userID}) async {

      var firebaseInvestments = 
        _firestore
        .collection('investments')
        .where('userID', isEqualTo: userID);

    final firebaseInvestmentsGet = await firebaseInvestments.get();

    final investments = 
    firebaseInvestmentsGet.docs
    .map(
      (e) => InvestmentModel.fromMap(
        Map<String, dynamic>.from(
          e.data(),
        ),
      ),
    ).toList();
    log(investments.length.toString());
    return investments;
  }

}