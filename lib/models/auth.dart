import 'dart:async';
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
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;
  Timer? _logOutTimer;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

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
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      _autoLogOut();
      notifyListeners();
    }
    print(body);
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, _signUp);
  }

  Future<void> signInWithPassword(String email, String password) async {
    return _authenticate(email, password, _signInWithPassword);
  }

  void logOut() {
    _token = null;
    _email = null;
    _userId = null;
    _expiryDate = null;
    _clearLogOutTimer();
    notifyListeners();
  }

  void _clearLogOutTimer() {
    _logOutTimer?.cancel();
    _logOutTimer = null;
  }

  void _autoLogOut() {
    _clearLogOutTimer();
    final timeToLogOut = _expiryDate?.difference(DateTime.now()).inSeconds;
    print(timeToLogOut);
    _logOutTimer = Timer(Duration(seconds: timeToLogOut ?? 0), logOut);
  }
}
