import 'package:intl/intl.dart';

class Constants {
  static const String apikey = "AIzaSyDKWLYNlzIHPPmp3M7LNxVruDvRbF-pKIo";
  static const String newsLine = 'DEADLINE Your Character is Suffering... '
      'But that\'s fine, there are 2.2 million animal species left. No worries! ';

  static changeDateFormat(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime).toString();
  }
}
