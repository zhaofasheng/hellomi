import 'package:intl/intl.dart';

class CustomFormatDate {
  static String onConvert(String value) {
    DateTime dateTime = DateTime.parse(value).toLocal();
    String formattedDate = DateFormat("dd-MM-yy HH:mm").format(dateTime);
    return formattedDate;
  }

  static String onDateConvert(String value) {
    // Parse original string using the correct format
    DateTime dateTime = DateFormat("M/d/yyyy, h:mm:ss a").parse(value, true).toLocal();

    // Format into the desired output
    String formattedDate = DateFormat("dd-MM-yy HH:mm").format(dateTime);
    return formattedDate;
  }
}
