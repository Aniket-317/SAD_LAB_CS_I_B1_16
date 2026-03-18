import 'package:flutter/material.dart';
import 'package:flutter_application_2/configurations.dart';
import 'package:flutter_application_2/utility.dart';

class RegisterPage extends StatefulWidget{
 @override
 State<StatefulWidget> createState() => RegisterPageState();
}
class RegisterPageState extends State<RegisterPage>{
  final _userID = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool? _isUserValid;
  bool? _isPasswordValid;

  void validate() {
    String userid = _userID.text.trim();
    String password = _password.text.trim();
    String confirm = _confirmPassword.text.trim();

    // Check user validity
    if (_isUserValid != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid or existing User ID')),
      );
      return;
    }

    // Check password validity
    if (_isPasswordValid != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid password')),
      );
      return;
    }

    // Confirm password match
    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Add to credentials list
    Configurations.credentials.add({
      'userid': userid,
      'password': password,
    });
    print(Configurations.credentials);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration successful')),
    );

    Navigator.pop(context); // go back to login
  }

 void checkUser(String value) {
    String id = value.trim();

    if (id.isEmpty) {
      setState(() => _isUserValid = null);
      return;
    }

    if (!Configurations.validateEmail(id)) {
      setState(() => _isUserValid = false);
      return;
    }

    if (!Configurations.isUserUnique(id)) {
      setState(() => _isUserValid = false);
      return;
    }

    setState(() => _isUserValid = true);
  }

  void checkPassword(String value) {
    String pass = value.trim();

    if (pass.isEmpty) {
      setState(() => _isPasswordValid = null);
      return;
    }

    if (!Utility.validatePassword(pass)) {
      setState(() => _isPasswordValid = false);
      return;
    }

    setState(() => _isPasswordValid = true);
  }

 @override
 Widget build(BuildContext context) {
   // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       leading: BackButton(
         onPressed: (){
           Navigator.pop(context);
         },
       ),
       title: Text('Register'),
       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     ),
     body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: _userID,
          onChanged: checkUser,
          decoration: InputDecoration(
            suffixIcon: _isUserValid == null
                ? null
                : (_isUserValid!
                    ? Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      )),
            labelText: 'User ID',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: _password,
          obscureText: true,
          onChanged: checkPassword,
          decoration: InputDecoration(
            suffixIcon: _isPasswordValid == null
                ? null
                : (_isPasswordValid!
                    ? Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      )),
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: _confirmPassword,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),

      ElevatedButton(
        onPressed: validate,
        child: Text('Register'),
      ),
    ],
  ),
),
);
}
}