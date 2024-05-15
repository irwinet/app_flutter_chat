import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 12),),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3,),
            Text('Irwin Estrada', style: TextStyle(color: Colors.black87, fontSize: 12),),
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
                itemBuilder: (_,i) => Text('$i'),
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
    print(texto);
    _focusNode.requestFocus();
    _textController.clear();

    setState(() {
      _estaEscribiendo = false;
    });
  }
}