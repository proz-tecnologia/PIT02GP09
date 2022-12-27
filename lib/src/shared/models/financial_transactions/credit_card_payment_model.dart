
import 'dart:convert';
import 'dart:core';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/abstract_classes/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/generic_expense_model.dart';

class CreditCardPayment extends GenericExpense {

  final String cardName;
  
  CreditCardPayment({
    required this.cardName,
    super.type = TransactionTypes.creditCardPayment,
    required super.name,
    required super.value,
    required super.date,
    super.userID,
    super.id,
  });


  @override
  CreditCardPayment copyWith({
    String? cardName,
    String? name,
    double? value,
    DateTime? date,
    String? userID,
    String? id,
  }) {
    return CreditCardPayment(
      cardName: cardName ?? this.cardName,
      name: name ?? this.name,
      value: value ?? this.value,
      date: date ?? this.date,
      userID: userID ?? this.userID,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardName': cardName,
      'type': type.toString(),
      'name' : name,
      'value': value,
      'date': date.toIso8601String(),
      'userID': userID,
      'id': id,
    };
  }

  factory CreditCardPayment.fromMap(Map<String, dynamic> map) {
    return CreditCardPayment(
      cardName: map['cardName'] as String,
      type: FinancialTransaction.transactionTypesFromString(map['type']) as TransactionTypes,
      name: map['name'] as String,
      value: map['value'] as double,
      date: DateTime.parse(map['date']),
      userID: map['userID'] != null ? map['userID'] as String : null,
      id: map['id'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory CreditCardPayment.fromJson(String source) => CreditCardPayment.fromMap(json.decode(source) as Map<String, dynamic>);

}