import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/constants.dart';

const _signUp = 'signUp';
const _signInWithPassword = 'signInWithPassword';
const _keyAPI = 'AIzaSyDemxYKMNtA0KVmutOOM5lF4lcm7Ikat-U';

class Auth with ChangeNotifier {
  //https://identitytoolkit.googleapis.com/v1/accounts: signUp?key=             [API_KEY]
  //https://identitytoolkit.googleapis.com/v1/accounts: signInWithPassword?key= [API_KEY]

  Future<void> _authenticate(
      String email, String password, String urlSignUpSignInFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSignUpSignInFragment?key=$_keyAPI';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }
    print(body);
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, _signUp);
  }

  Future<void> signInWithPassword(String email, String password) async {
    return _authenticate(email, password, _signInWithPassword);
  }
}
