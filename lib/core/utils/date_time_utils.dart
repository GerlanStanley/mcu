import 'package:intl/intl.dart';

import 'utils.dart';

class DateTimeUtils {
  static String dateToString(String date) {
    try {
      DateTime todayDate = DateTime.parse(date);
      var formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(todayDate);
    } on Exception catch (_) {
      return '';
    }
  }

  static String dateToStringDatabase(String date) {
    try {
      DateTime dateTime = DateFormat("dd/MM/yyyy").parse(date);
      var formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(dateTime);
    } on Exception catch (e) {
      printDebug(e);
      return '';
    }
  }

  static String dateTimeNawToString() {
    try {
      var formatter = DateFormat('ddMMyyyy');
      return formatter.format(DateTime.now());
    } on Exception catch (e) {
      printDebug(e);
      return '';
    }
  }

  static String formattedDateTime(DateTime date) {
    return DateFormat("dd/MM/yyyy HH:mm:ss").format(date);
  }

  static String formattedDateTimeWithoutSeconds(DateTime date) {
    return DateFormat("dd/MM/yyyy HH:mm").format(date);
  }

  static String formattedDate(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }

  static String formattedTime(DateTime date) {
    return DateFormat("HH:mm:ss").format(date);
  }

  static String formattedDatabaseDate(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  static String formattedDatabaseDateTime(DateTime date) {
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
  }

  static String formattedWeekDay(DateTime date) {
    return DateFormat('EEEE', "pt_BR").format(date);
  }

  static String formattedMonth(DateTime date) {
    return DateFormat("MMMM", "pt_BR").format(date);
  }

  static String formattedMonthDay(DateTime date) {
    return DateFormat("MMMMd", "pt_BR").format(date);
  }

  static String formattedMonthYear(DateTime date) {
    return DateFormat("yMMMM", "pt_BR").format(date);
  }
}