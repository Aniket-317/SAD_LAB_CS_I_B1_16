import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {

  final TextEditingController useridController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool isUserIdValid = false;
  bool isPasswordValid = false;
  bool doPasswordsMatch = false;

  void validate() {
    setState(() {
      isUserIdValid =
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
              .hasMatch(useridController.text);

      isPasswordValid = passwordController.text.length >= 6;
      doPasswordsMatch =
          passwordController.text == confirmPasswordController.text;
    });

    if (isUserIdValid && isPasswordValid && doPasswordsMatch) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
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
                controller: useridController,
                onChanged: (value) {
                  setState(() {
                    isUserIdValid =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: Icon(
                    isUserIdValid
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: isUserIdValid
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                onChanged: (value) {
                  setState(() {
                    isPasswordValid = value.length >= 6;
                    doPasswordsMatch =
                        confirmPasswordController.text == value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                onChanged: (value) {
                  setState(() {
                    doPasswordsMatch =
                        value == passwordController.text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        doPasswordsMatch
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: doPasswordsMatch
                            ? Colors.green
                            : Colors.red,
                      ),
                      IconButton(
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword =
                                !obscureConfirmPassword;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
                onPressed: validate,
                child: Text('Register')
            )
          ],
        ),
      ),
    );
  }
}
