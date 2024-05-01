import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class AppAuth {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

  static String numberFormat(double n, {int min = 2, int max = 6}) {
    // var formatter = NumberFormat('#,###,000');
    var ft = NumberFormat();
    ft.minimumFractionDigits = min;
    ft.maximumFractionDigits = max;
    return ft.format(n);
    // var f = NumberFormat.currency(symbol: "", decimalDigits: 6);
    // return f.format(n);
  }
}
