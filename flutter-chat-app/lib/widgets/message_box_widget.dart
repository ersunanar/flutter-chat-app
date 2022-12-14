import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({Key? key}) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() {
    print('send message');

    //Firebase send message
    _controller.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                hintText: 'Type your message...',
                labelStyle: TextStyle(color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color.fromRGBO(64, 55, 55, 1.0)),
                  gapPadding: 8,
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  message = newValue;
                });
              },
            ),
          ),

          SizedBox(width: 16,),

          GestureDetector(
            onTap: message.trim().isEmpty ? null:sendMessage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
