import 'package:app_flutter_chat/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { OnLine, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  // SocketService() {
  //   _initConfig();
  // }

  void connect() {
    print('_initConfig');
    // Dart client
    // IP Emulator = 10.0.2.2
    
    this._socket = IO.io(Environment.sockerURL, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true
    });

    //IO.Socket socket = IO.io('http://10.0.2.2:3000', IO.OptionBuilder().setTransports(['transports']).enableAutoConnect().build());

    this._socket.onConnect((_) {
      print('connect');
      this._serverStatus = ServerStatus.OnLine;
      notifyListeners();
      //socket.emit('mensaje', 'test');
    });
    this._socket.onDisconnect((_) {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    this._socket.onConnectError((error) => print('Error al conectar: $error'));
    this._socket.onReconnect((attempt) => print('Reintentando conexión, intento: $attempt'));
    // this._socket.on('event', (data) => print(data));
    // this._socket.on('fromServer', (_) => print(_));

    // this._socket.on('nuevo-mensaje', (payload) {
    //   print('nuevo-mensaje:');
    //   print('nombre: '+ payload['nombre']);
    //   print(payload.containsKey('mensaje2') ? payload['mensaje2']: 'no hay');
    // });
  }

  void disconnect(){
    this._socket.disconnect();
  }
}
