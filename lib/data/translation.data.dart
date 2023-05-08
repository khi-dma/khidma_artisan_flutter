import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_EN': {
          "work": "Work",
          "appearance":"Appearance",
          "language":"Language",
          "portfolio":"Portfolio",
          "availability":"Availability"
        },
        'fr_FR': {}
      };
}
