import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_repository.dart';
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

}