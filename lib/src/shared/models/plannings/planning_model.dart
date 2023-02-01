import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PlanningModel {

  final String name;
  final double value;
  final Timestamp finalDate;
  final String? userID;
  final String? id;
  PlanningModel({
    required this.name,
    required this.value,
    required this.finalDate,
    this.userID,
    this.id,
  });

   String get formattedDate => DateFormat('dd/MM/yyyy').format(finalDate.toDate());  

  PlanningModel copyWith({
    String? name,
    double? value,
    Timestamp? finalDate,
    String? userID,
    String? id,
  }) {
    return PlanningModel(
      name: name ?? this.name,
      value: value ?? this.value,
      finalDate: finalDate ?? this.finalDate,
      userID: userID ?? this.userID,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'finalDate': finalDate,
      'userID' : userID,
      'id': id,
    };
  }

  factory PlanningModel.fromMap(Map<String, dynamic> map) {
    return PlanningModel(
      name: map['name'] as String,
      value: map['value'] as double,
      finalDate: map['finalDate'],
      userID: map['userID'] != null ? map['userID'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanningModel.fromJson(String source) => PlanningModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlanningModel(name: $name, value: $value, finalDate: $finalDate, userID: $userID, id: $id)';

  @override
  bool operator ==(covariant PlanningModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.value == value &&
      other.finalDate == finalDate &&
      other.userID == userID &&
      other.id == id ;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode ^ finalDate.hashCode ^ userID.hashCode ^ id.hashCode;
}
