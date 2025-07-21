extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension StringExtension on String {
  String formatByTNT() {
    var list = split(".");
    if (list[1].length > 10) {
      return "${list[0]}.${list[1].substring(0, 10)}";
    }
    return this;
  }
}

extension DateTimeExtension on DateTime {
  DateTime formatToDate() {
    return DateTime(year, month, day);
  }
}
