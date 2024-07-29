import 'package:intl/intl.dart';

class Constants {
  static const String apikey = "AIzaSyDKWLYNlzIHPPmp3M7LNxVruDvRbF-pKIo";
  static const String newsLine = 'DEADLINE Your animal is suffering '
      'but that\'s totally fine! There are 2.2 million animal species left. '
      'Feeling Uncomfortable? You will be more uncomfortable if you don\'t act now! ';

  static changeDateFormat(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime).toString();
  }
}
