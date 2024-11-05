import "package:intl/intl.dart";

extension MoneyDouble on double {
  String get moneyFormat {
    NumberFormat format = new NumberFormat("#,##0.00");
    return format.format(this);
  }
}

class MoneyFormat{

}