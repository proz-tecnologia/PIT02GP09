import 'dart:convert';

class Month {

  final String monthName;

  Month({
    required this.monthName,
  }); 

  Month copyWith({
    String? monthName,
  }) {
    return Month(
      monthName: monthName ?? this.monthName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'monthName': monthName,
    };
  }

  factory Month.fromMap(Map<String, dynamic> map) {
    return Month(
      monthName: map['monthName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Month.fromJson(String source) => Month.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Month(monthName: $monthName)';

  @override
  bool operator ==(covariant Month other) {
    if (identical(this, other)) return true;
  
    return 
      other.monthName == monthName;
  }

  @override
  int get hashCode => monthName.hashCode;
}
