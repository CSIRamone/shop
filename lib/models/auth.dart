import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class Auth with ChangeNotifier {
  static const _URL =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDemxYKMNtA0KVmutOOM5lF4lcm7Ikat-U';
  Future<void> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse(_URL),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    print(jsonDecode(response.body));
  }
}
