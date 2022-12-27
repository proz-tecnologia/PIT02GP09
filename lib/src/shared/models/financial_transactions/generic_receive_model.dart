
import 'dart:convert';
import 'dart:core';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/abstract_classes/financial_transaction.dart';

class GenericReceive extends FinancialTransaction {
  
  GenericReceive({
    super.type = TransactionTypes.genericReceive,
    required super.name,
    required super.value,
    required super.date,
    super.userID,
    super.id,
  });

  GenericReceive copyWith({
    String? name,
    double? value,
    DateTime? date,
    String? userID,
    String? id,
  }) {
    return GenericReceive(
      name: name ?? this.name,
      value: value ?? this.value,
      date: date ?? this.date,
      userID: userID ?? this.userID,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.toString(),
      'name' : name,
      'value': value,
      'date': date.toIso8601String(),
      'userID': userID,
      'id': id,
    };
  }

  factory GenericReceive.fromMap(Map<String, dynamic> map) {
    return GenericReceive(
      type: FinancialTransaction.transactionTypesFromString(map['type']) as TransactionTypes,
      name: map['name'] as String,
      value: map['value'] as double,
      date: DateTime.parse(map['date']),
      userID: map['userID'] != null ? map['userID'] as String : null,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GenericReceive.fromJson(String source) => GenericReceive.fromMap(json.decode(source) as Map<String, dynamic>);

}
