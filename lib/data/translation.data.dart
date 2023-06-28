import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_EN': {
          "savedPost":"Saved Posts",
          "work": "Work",
          "appearance":"Appearance",
          "language":"Language",
          "portfolio":"Portfolio",
          "availability":"Availability",
          "verificationCode": "Verification code",
          "confirmDesc": "Please enter the verification code \nsent to ",
        },
        'fr_FR': {}
      };
}
