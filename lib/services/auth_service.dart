
import 'dart:convert';

import 'package:app_flutter_chat/global/environment.dart';
import 'package:app_flutter_chat/models/login_response.dart';
import 'package:app_flutter_chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  
  late Usuario usuario;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando (bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }
  
  Future<bool> login(String email, String password) async {

    this.autenticando = true;

    final data = {
      'email': email,
      'password': password
    };  

    final uri = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print(resp.body);
    
    this.autenticando = false;

    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {
      return false;
    }    

  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }


}