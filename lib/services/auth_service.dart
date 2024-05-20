
import 'dart:convert';

import 'package:app_flutter_chat/global/environment.dart';
import 'package:app_flutter_chat/models/login_response.dart';
import 'package:app_flutter_chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  
  late Usuario usuario;
  bool _autenticando = false;

  bool get autenticando => this._autenticando;
  set autenticando (bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }
  
  Future login(String email, String password) async {

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
    
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
    }

    this.autenticando = false;

  }
}