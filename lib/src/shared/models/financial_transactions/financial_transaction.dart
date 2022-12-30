import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


enum TransactionTypes {
  expense,
  receive,
}

class FinancialTransaction {

  final TransactionTypes type;
  final String name;
  final double value;
  final Timestamp date;
  final String? userID;
  final String? id;
  
  FinancialTransaction({
    required this.type,
    required this.name,
    required this.value,
    required this.date,
    this.userID,
    this.id,
  });

  String get formattedDate => DateFormat('dd/MM/yyyy').format(date.toDate());

  FinancialTransaction copyWith({
    TransactionTypes? type,
    String? name,
    double? value,
    Timestamp? date,
    String? userID,
    String? id,
  }) {
    return FinancialTransaction(
      type: type ?? this.type,
      name: name ?? this.name,
      value: value ?? this.value,
      date: date ?? this.date,
      userID: userID ?? this.userID,
      id: id ?? this.id,
    );
  }

  static TransactionTypes? transactionTypeFromString(String transaction) {
    switch (transaction) {
      case 'TransactionTypes.expense':
        return TransactionTypes.expense;
      case 'TransactionTypes.receive':
        return TransactionTypes.receive;
      default:
        return null;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.toString(),
      'name': name,
      'value': value,
      'date': date,
      'userID': userID,
      'id': id,
    };
  }

  factory FinancialTransaction.fromMap(Map<String, dynamic> map) {
    return FinancialTransaction(
      type: transactionTypeFromString(map['type']) as TransactionTypes,
      name: map['name'] as String,
      value: map['value'] as double,
      date: map['date'],
      userID: map['userID'] != null ? map['userID'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialTransaction.fromJson(String source) => FinancialTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinancialTransaction(type: $type, name: $name, value: $value, date: $date, userID: $userID, id: $id)';
  }

  @override
  bool operator ==(covariant FinancialTransaction other) {
    if (identical(this, other)) return true;
  
    return 
      other.type == type &&
      other.name == name &&
      other.value == value &&
      other.date == date &&
      other.userID == userID &&
      other.id == id;
  }

  @override
  int get hashCode {
    return type.hashCode ^
      name.hashCode ^
      value.hashCode ^
      date.hashCode ^
      userID.hashCode ^
      id.hashCode;
  }
}
