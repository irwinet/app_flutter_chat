import 'package:app_flutter_chat/global/environment.dart';
import 'package:app_flutter_chat/models/mensajes_response.dart';
import 'package:app_flutter_chat/models/usuario.dart';
import 'package:app_flutter_chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;
  

  Future<List<Mensaje>> getChat(String usuarioID) async {
    
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');        
    final resp = await http.get(uri,
    headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()??'',
    });

    final mensajesResponse = mensajesResponseFromJson(resp.body);

    return mensajesResponse.mensajes;
  }
}