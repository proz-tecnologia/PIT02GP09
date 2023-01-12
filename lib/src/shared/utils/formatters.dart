import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Formatters {

  static String formatToReal(double value ) {
    String formatedValue = value.toStringAsFixed(2).replaceFirst(".", ",");
    return "R\$ $formatedValue";
  }

  static String formatToDate(Timestamp value) {
    final formattedValue = DateFormat('dd/MM/yyyy').format(value.toDate());
    return formattedValue;
  }

}