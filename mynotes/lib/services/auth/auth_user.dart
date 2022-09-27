import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  const AuthUser(this.isEmailVerified);

  factory AuthUser.fromFirebase(User user)  => AuthUser(user.emailVerified);
}

// class MyAuthUser extends AuthUser {
//   bool isBla = false;
//   MyAuthUser(bool isEmailVerified) : super(isEmailVerified);
// }
