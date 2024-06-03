
import 'package:app_flutter_chat/global/environment.dart';
import 'package:app_flutter_chat/models/usuarios_response.dart';
import 'package:app_flutter_chat/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_chat/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');

      final resp = await http.get(uri, 
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()??'',
        }
      );

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}