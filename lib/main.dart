import 'package:flutter/material.dart';
import 'package:flutter_application_2/register_page.dart';
import 'package:flutter_application_2/utility.dart';

void main() {
 runApp(const MyApp());
}


class MyApp extends StatelessWidget {
 const MyApp({super.key});


 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Flutter Demo',
     theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
     home: const MyHomePage(title: 'Login'),
   );
 }
}


class MyHomePage extends StatefulWidget {
 const MyHomePage({super.key, required this.title});


 final String title;


 @override
 State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
 final _userID = TextEditingController(), _password = TextEditingController();
 String? _userIDErrorText, _passwordErrorText;


 void validate() {
   setState(() {
     _userIDErrorText = _setUserIDErrorText(_userID.text);
     _passwordErrorText = _setPasswordErrorText(_password.text);
   });
 }


 String? _setUserIDErrorText(String value) {
   if (value.isEmpty) return 'Please enter email ID';
   if (!Utility.validateEmail(value))
     return 'Please enter valid email ID';
   return null;
 }


 String? _setPasswordErrorText(String value) {
   if (value.isEmpty) return 'Please enter Password';
   return null;
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       title: Text(widget.title),
     ),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: ValueListenableBuilder<TextEditingValue>(
               valueListenable: _userID,
               builder: (context, value, child) {
                 _userIDErrorText = _setUserIDErrorText(value.text);
                 return TextField(
                   controller: _userID,
                   decoration: InputDecoration(
                     labelText: 'User ID',
                     errorText: _userIDErrorText,
                     hintText: 'aniket.patankar@gmail.com',
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20),
                     ),
                   ),
                 );
               }
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: TextField(
               obscureText: true,
               controller: _password,
               decoration: InputDecoration(
                 labelText: 'Password',
                 errorText: _passwordErrorText,
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20),
                 ),
               ),
             ),
           ),
           ElevatedButton(onPressed: validate, child: Text('Login')),
           ElevatedButton(onPressed: (){
             Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterPage()
             ));
           }, child: Text('Sign Up')),
         ],
       ),
     ),
   );
 }


 @override
 void dispose() {
   // TODO: implement dispose
   super.dispose();
 }
}
