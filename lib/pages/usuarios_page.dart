import 'package:app_flutter_chat/models/usuario.dart';
import 'package:app_flutter_chat/services/auth_service.dart';
import 'package:app_flutter_chat/services/chat_service.dart';
import 'package:app_flutter_chat/services/socket_service.dart';
import 'package:app_flutter_chat/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuariosPage extends StatefulWidget {

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuariosService = new UsuariosService();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<Usuario> usuarios = [];

  // final usuarios = [
  //   Usuario(online: true, email: 'test1@test.com', nombre: 'Maria', uid: '1'),
  //   Usuario(online: true, email: 'test2@test.com', nombre: 'Melissa', uid: '2'),
  //   Usuario(online: true, email: 'test3@test.com', nombre: 'Fernando', uid: '3'),
  // ];

  @override
  void initState() {
    // TODO: implement initState
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre, style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          }, 
          icon: Icon(Icons.exit_to_app, color: Colors.black87,)
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            // child: Icon(Icons.check_circle, color: Colors.blue[400],),
            child: 
              (socketService.serverStatus == ServerStatus.OnLine)
              ? Icon(Icons.check_circle, color: Colors.blue[400],)
              : Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _cargarUsuarios,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: ( _, i) => _usuarioListTile(usuarios[i]), 
      separatorBuilder: ( _, i) => Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: () {
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.usuarioPara = usuario;
          Navigator.pushNamed(context, 'chat');
        },
      );
  }

  _cargarUsuarios() async{
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
  
    this.usuarios = await usuariosService.getUsuarios();
    setState(() {
      
    });

    _refreshController.refreshCompleted();
  }
}