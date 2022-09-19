import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        margin:
            EdgeInsets.only(left: 10.0, right: 40.0, bottom: 10.0, top: 10.0),
        decoration: BoxDecoration(
            color: PrimaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubblForFriend extends StatelessWidget {
  final Message message;

  ChatBubblForFriend({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        margin:
            EdgeInsets.only(left: 10.0, right: 40.0, bottom: 10.0, top: 10.0),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
