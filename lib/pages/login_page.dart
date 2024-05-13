import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Logo(),
            _Form(),
            _Labels(),
            Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
          ],
        ),
      ),
   );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: const Column(
          children: [
            Image(image: AssetImage('assets/tag-logo.png')),
            SizedBox(height: 20,),
            Text('Messenger', style: TextStyle(fontSize: 30),)
          ],
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(),
          TextField(),

          ElevatedButton(onPressed: () {  }, child: null,)
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('¿No tienes cuenta?', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),),
          SizedBox(height: 10,),
          Text('Crea una ahora!', style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}