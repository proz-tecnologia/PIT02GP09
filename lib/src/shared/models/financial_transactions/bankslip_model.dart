
import 'dart:convert';
import 'dart:core';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/abstract_classes/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/generic_expense_model.dart';

class BankSlip extends GenericExpense {

  final String? barCode;
  final String? dueDate;
  final String? receiverName;
  
  BankSlip({
    this.barCode,
    this.dueDate,
    this.receiverName,
    super.type = TransactionTypes.bankSlip,
    required super.name,
    required super.value,
    required super.date,
    super.userID,
    super.id,
  });

  @override
  BankSlip copyWith({
    String? barCode,
    String? dueDate,
    String? receiverName,
    String? name,
    double? value,
    DateTime? date,
    String? userID,
    String? id,
  }) {
    return BankSlip(
      barCode: barCode ?? this.barCode,
      dueDate: dueDate ?? this.dueDate,
      receiverName: receiverName ?? this.receiverName,
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
      'barCode': barCode,
      'dueDate': dueDate,
      'receiverName': receiverName,
      'type': type.toString(),
      'name' : name,
      'value': value,
      'date': date.toIso8601String(),
      'userID': userID,
      'id': id,
    };
  }

  factory BankSlip.fromMap(Map<String, dynamic> map) {
    return BankSlip(
      barCode: map['barCode'] != null ? map['barCode'] as String : null,
      dueDate: map['dueDate'] != null ? map['dueDate'] as String : null,
      receiverName: map['receiverName'] != null ? map['receiverName'] as String : null,
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

  factory BankSlip.fromJson(String source) => BankSlip.fromMap(json.decode(source) as Map<String, dynamic>);

}
