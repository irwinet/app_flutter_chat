import 'package:app_flutter_chat/helpers/mostrar_alerta.dart';
import 'package:app_flutter_chat/services/auth_service.dart';
import 'package:app_flutter_chat/services/socket_service.dart';
import 'package:app_flutter_chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import 'package:app_flutter_chat/widgets/custom_input.dart';
import 'package:app_flutter_chat/widgets/custom_labels.dart';
import 'package:app_flutter_chat/widgets/custom_logo.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(
                  titulo: 'Messenger',
                ),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: 'Crea una ahora!',
                  subtitulo: '¿No tienes cuenta?',
                ),
                Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      ),
   );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {


  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ), 

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),         
              

          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.autenticando ? null : () async {
              print(emailCtrl.text);
              print(passCtrl.text);
              FocusScope.of(context).unfocus();
              
              final loginOK = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

              if(loginOK){
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Login incorrecto', 'Revisen sus credenciales');
              }
            },
          )
        ],
      ),
    );
  }
}
