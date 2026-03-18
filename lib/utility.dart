class Utility {
  
 static bool validateEmail(String text) {
   return RegExp(
     r"^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z]{2,4}){1,2}$",
   ).hasMatch(text);
 }

  static bool validatePassword(String text) {
      return RegExp(
        r'^(?=(?:.*[A-Za-z]){2,})(?=.*\d)(?=.*[^A-Za-z0-9]).{7,}$',
      ).hasMatch(text);
  }

}