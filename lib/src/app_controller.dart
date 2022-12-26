
import 'package:firebase_auth/firebase_auth.dart';

class AppController {
  User? user;

  void setUser(User newUser) => user = newUser;
}