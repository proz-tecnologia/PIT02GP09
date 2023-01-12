
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PlanningModel {

  final String name;
  final double value;
  final Timestamp finalDate;
  final String? userID;
  PlanningModel({
    required this.name,
    required this.value,
    required this.finalDate,
    required this.userID,
  });

   String get formattedDate => DateFormat('dd/MM/yyyy').format(finalDate.toDate());  

  PlanningModel copyWith({
    String? name,
    double? value,
    Timestamp? finalDate,
    String? userID,
  }) {
    return PlanningModel(
      name: name ?? this.name,
      value: value ?? this.value,
      finalDate: finalDate ?? this.finalDate,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'finalDate': finalDate,
      'userID' : userID,
    };
  }

  factory PlanningModel.fromMap(Map<String, dynamic> map) {
    return PlanningModel(
      name: map['name'] as String,
      value: map['value'] as double,
      finalDate: map['finalDate'],
      userID: map['userID'] != null ? map['userID'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanningModel.fromJson(String source) => PlanningModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlanningModel(name: $name, value: $value, finalDate: $finalDate, userID: $userID)';

  @override
  bool operator ==(covariant PlanningModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.value == value &&
      other.finalDate == finalDate &&
      other.userID == userID;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode ^ finalDate.hashCode ^ userID.hashCode;
}
