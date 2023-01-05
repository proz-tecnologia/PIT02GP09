import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_respository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateWalletRepositoryImpl implements CreateWalletRepository {

  @override
  final SharedPreferences sharedPreferences;
  
  CreateWalletRepositoryImpl({required this.sharedPreferences});

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  @override
  Future<void> createWallet({required WalletModel wallet}) async {

    // cria carteira e automaticamente gera um id
    final response = await _firestore
    .collection('wallets')
    .add(wallet.toMap());

    // update na carteira criada anteriormente adicionando o id gerado na criacao
    await _firestore
    .collection('wallets')
    .doc(response.id)
    .update({'id' : response.id});

    return Future.delayed(const Duration(seconds: 2));
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
  Future<void> updateWalletValue({required WalletModel wallet}) async {
    // update apenas do parametro 'value' da carteira no Firebase
    await _firestore
    .collection('wallets')
    .doc(wallet.id)
    .update({'value' : wallet.value});
  }
  
}