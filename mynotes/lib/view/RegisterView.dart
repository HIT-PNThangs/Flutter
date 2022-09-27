import 'package:flutter/material.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exception.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter your email'),
          ),
          TextField(
            controller: _password,
            obscureText: true, // dấu passwpord
            enableSuggestions: false,
            decoration: const InputDecoration(hintText: 'Enter your password'),
          ),
          TextButton(
              onPressed: () async {
                try {
                  final String email = _email.text;
                  final String password = _password.text;

                  await AuthService.firebase()
                      .createUser(email: email, password: password);

                  await AuthService.firebase().sendEmailVerification();

                  Navigator.of(context).pushNamed(verityEmailRoute);
                } on WeakPasswordAuthException {
                  await showErrorDialog(context, "Wrong password");
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(context, "Email is already in use");
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                      context, "This is an invalid email address");
                } on GenericAuthException {
                  await showErrorDialog(context, "Failed to register user");
                }
              },
              child: const Text('Register')),
          TextButton(
            onPressed: () async {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login/', (route) => false);
            },
            child: const Text('Already registered? Login here'),
          )
        ],
      ),
    );
  }
}
