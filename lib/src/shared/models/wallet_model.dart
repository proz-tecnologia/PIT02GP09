import 'dart:convert';


class WalletModel {

  final String name;
  double value;
  final String? userID;
  final String? id;
  
  WalletModel({
    required this.name,
    required this.value,
    this.userID,
    this.id,
  });


  WalletModel copyWith({
    String? name,
    double? value,
    String? userID,
    String? id,
  }) {
    return WalletModel(
      name: name ?? this.name,
      value: value ?? this.value,
      userID: userID ?? this.userID,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'userID': userID,
      'id': id,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      name: map['name'] as String,
      value: map['value'] as double,
      userID: map['userID'] != null ? map['userID'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) => WalletModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WalletModel(name: $name, value: $value, userID: $userID, id: $id)';
  }

  @override
  bool operator ==(covariant WalletModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.value == value &&
      other.userID == userID &&
      other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      value.hashCode ^
      userID.hashCode ^
      id.hashCode;
  }
}
