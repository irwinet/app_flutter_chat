import 'package:app_flutter_chat/services/auth_service.dart';
import 'package:app_flutter_chat/services/chat_service.dart';
import 'package:app_flutter_chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_chat/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService(),),
        ChangeNotifierProvider(create: (_) => SocketService(),),
        ChangeNotifierProvider(create: (_) => ChatService(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}