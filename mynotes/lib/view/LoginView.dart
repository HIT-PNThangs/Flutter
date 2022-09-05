import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  // Đây là phương thức đầu tiên được gọi khi widget được tạo.
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  // dispose() được gọi khi đối tượng State bị xóa vĩnh viễn.
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
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
              decoration:
                  const InputDecoration(hintText: 'Enter your password'),
            ),
            TextButton(
                onPressed: () async {
                  final String email = _email.text;
                  final String password = _password.text;

                  try {
                    // await: xử lý bất đồng bộ
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, 
                      password: password
                    );

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/notes/', (route) => false);

                  } on FirebaseAuthException catch (e) {
                    devtools.log("Login: $e");

                    if (e.code == 'user-not-found') {
                      devtools.log("Login: User not found");
                    } else if (e.code == 'wrong-password') {
                      devtools.log("Wrong password");
                    }
                  }
                },
                child: const Text('Login')),
            TextButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/register/', (route) => false);
                },
                child: const Text('Not registered? Register here!'))
          ],
        ));
  }
}
