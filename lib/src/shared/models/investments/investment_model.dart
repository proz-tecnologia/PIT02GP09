import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class InvestmentModel {

  String name;
  Timestamp initialDate;
  double initialValue;
  double incomeRateByDay;
  double currentValue;
  final String? userID;
  final String? id;
  
  InvestmentModel({
    required this.name,
    required this.initialDate,
    required this.initialValue,
    required this.incomeRateByDay,
    this.currentValue = 0.0,
    this.userID,
    this.id,
  });

  String get formattedDate => DateFormat('dd/MM/yyyy').format(initialDate.toDate());

  void updateCurrentValue() {
    final dateForm = initialDate.toDate();
    final passedTime = DateTime.now().difference(dateForm).inDays;
    currentValue = initialValue * (1 + incomeRateByDay) * passedTime;
  }

  double getValueAtTime(DateTime date) {
    final dateForm = initialDate.toDate();
    double givenTimeValue = 0.0;
    final passedTime = DateTime.now().difference(date).inDays;
    if (date.isAfter(dateForm)) {
      givenTimeValue = initialValue * (1 + incomeRateByDay) * passedTime;      
    }
    return givenTimeValue;
  } 

  InvestmentModel copyWith({
    String? name,
    Timestamp? initialDate,
    double? initialValue,
    double? incomeRateByDay,
    double? currentValue,
    String? userID,
    String? id,
  }) {
    return InvestmentModel(
      name: name ?? this.name,
      initialDate: initialDate ?? this.initialDate,
      initialValue: initialValue ?? this.initialValue,
      incomeRateByDay: incomeRateByDay ?? this.incomeRateByDay,
      currentValue: currentValue ?? this.currentValue,
      userID: userID ?? this.userID,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'initialDate': initialDate,
      'initialValue': initialValue,
      'incomeRateByDay': incomeRateByDay,
      'currentValue': currentValue,
      'userID': userID,
      'id': id,
    };
  }

  factory InvestmentModel.fromMap(Map<String, dynamic> map) {
    return InvestmentModel(
      name: map['name'] as String,
      initialDate: map['initialDate'],
      initialValue: map['initialValue'] as double,
      incomeRateByDay: map['incomeRateByDay'] as double,
      currentValue: map['currentValue'] as double,
      userID: map['userID'] != null ? map['userID'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvestmentModel.fromJson(String source) => InvestmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Investment(name: $name, initialDate: $initialDate, initialValue: $initialValue, incomeRateByDay: $incomeRateByDay, currentValue: $currentValue, userID: $userID, id: $id)';
  }

  @override
  bool operator ==(covariant InvestmentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.initialDate == initialDate &&
      other.initialValue == initialValue &&
      other.incomeRateByDay == incomeRateByDay &&
      other.currentValue == currentValue &&
      other.userID == userID &&
      other.id == id ;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      initialDate.hashCode ^
      initialValue.hashCode ^
      incomeRateByDay.hashCode ^
      currentValue.hashCode ^
      userID.hashCode ^
      id.hashCode;
  }
  
}