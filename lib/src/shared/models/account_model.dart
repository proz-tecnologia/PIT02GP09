import 'dart:convert';

class Account {

  final double balance;
  final String userID;
  final String userName;
  
  Account({
    required this.balance,
    required this.userID,
    required this.userName,
  });

  Account copyWith({
    double? balance,
    String? userID,
    String? userName,
  }) {
    return Account(
      balance: balance ?? this.balance,
      userID: userID ?? this.userID,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'balance': balance,
      'userID': userID,
      'userName': userName,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      balance: map['balance'] as double,
      userID: map['userID'] as String,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Account(balance: $balance, userID: $userID, userName: $userName)';

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;
  
    return 
      other.balance == balance &&
      other.userID == userID &&
      other.userName == userName;
  }

  @override
  int get hashCode => balance.hashCode ^ userID.hashCode ^ userName.hashCode;
}
