import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

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
                        email: email, password: password);

                    final user = await FirebaseAuth.instance.currentUser;
                    if (user?.emailVerified ?? false) {
                      // user's email is verified
                      Navigator.of(context)
                        .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                    } else {
                      // user's email is not verified
                      Navigator.of(context)
                        .pushNamedAndRemoveUntil(verityEmailRoute, (route) => false);
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      await showErrorDialog(context, "User not found");
                    } else if (e.code == 'wrong-password') {
                      await showErrorDialog(context, "Wrong password");
                    } else {
                      await showErrorDialog(context, "Error ${e.code}");
                    }
                  } catch (e) {
                    await showErrorDialog(context, e.toString());
                  }
                },
                child: const Text('Login')),
            TextButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                },
                child: const Text('Not registered? Register here!'))
          ],
        ));
  }
}
