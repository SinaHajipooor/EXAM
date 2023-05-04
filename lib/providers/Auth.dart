import 'dart:convert';

import 'package:flutter/material.dart';
import '../http/api.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth with ChangeNotifier {
  // ---------------- feilds ------------------
  String? _token;
  int? _userId;
  // final storage = FlutterSecureStorage();
  // ---------------- getter ------------------
  bool? get isAuth {
    return _token != null;
  }

  String? get token {
    return _token;
  }

  // ---------------- methods ------------------
  // login
  Future<Map<String, int>> login(String phoneNumber) async {
    try {
      String loginUrl = Api.instance.loginUrl;
      // send request
      final response = await http.post(Uri.parse(loginUrl), headers: <String, String>{'Content-Type': 'application/json'}, body: jsonEncode({'mobile': phoneNumber}));
      if (response.statusCode != 200) {
        throw Exception('Failed to authenticate user');
      }
      final Map<String, dynamic> userData = jsonDecode(response.body);
      final int id = userData['result']['user']?['id'];
      final int otpToken = userData['result']['otp_token'];
      return {'id': id, 'otp_token': otpToken};
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  // confirm
  Future<void> confirm(Map<String, dynamic> userData) async {
    try {
      String confirmUrl = Api.instance.confirmUrl;
      final http.Response response = await http.post(
        Uri.parse(confirmUrl),
        body: json.encode({'user_id': userData['user_id'], 'otp_token': userData['otp_token'], 'req_otp_code': userData['req_token_code']}),
        headers: {'Content-Type': 'application/json'},
      );
      final Map<String, dynamic>? responseData = json.decode(response.body) as Map<String, dynamic>?;
      _userId = responseData?['result']?['user']?['id'] as int? ?? _userId;
      _token = responseData?['result']?['token'] as String? ?? _token;
      notifyListeners();
      // await storage.write(key: 'userData', value: json.encode({'userId': _userId, 'token': _token}));
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  // logout
  Future<void> logout() async {
    // remove user data from memory
    _token = null;
    _userId = null;
    // remove user data from device storage
    // storage.delete(key: 'userData');
    notifyListeners();
  }
}
