import 'package:intl/intl.dart';

class NplusoneFormatter {
  static final _currencyFormatter = NumberFormat.simpleCurrency(
    locale: 'ko_KR',
    name: '',
    decimalDigits: 0,
  );

  static String formatCurrency(int number) {
    return _currencyFormatter.format(number);
  }
}