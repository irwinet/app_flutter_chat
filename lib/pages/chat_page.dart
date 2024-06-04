import 'dart:io';

import 'package:app_flutter_chat/services/chat_service.dart';
import 'package:app_flutter_chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  List<ChatMessage> _messages = [
    
  ];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {

    final chatService = Provider.of<ChatService>(context);
    final usuarioPara = chatService.usuarioPara;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(usuarioPara.nombre.substring(0,2), style: TextStyle(fontSize: 12),),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3,),
            Text(usuarioPara.nombre, style: TextStyle(color: Colors.black87, fontSize: 12),),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),  
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_,i) => _messages[i],
                itemCount: _messages.length,
                reverse: true,
              ),
            ),

            Divider(height: 1,),

            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),    
   );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (value) {
                  setState(() {
                    if(value.trim().length > 0){
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS ? 
                CupertinoButton(
                  child: Text('Enviar'), 
                  onPressed: _estaEscribiendo ? () => _handleSubmit(_textController.text.trim()) : null,
                )
                :
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.send),
                      onPressed: _estaEscribiendo ? () => _handleSubmit(_textController.text.trim()) : null,
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;

    print(texto);
    _focusNode.requestFocus();
    _textController.clear();

    final newMessage = new ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}