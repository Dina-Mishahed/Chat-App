import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static String id = "ChatScreen";
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controller.animateTo(
      0,
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    List<Message> messagesList = [];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          //automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/scholar.png",
                height: 50.0,
              ),
              Text("chat"),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: messages.orderBy("time", descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (ConnectionState.active == snapshot.connectionState) {
                    messagesList.removeRange(0, messagesList.length);
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      print("${snapshot.data!.docs[i]['email']}");
                      messagesList
                          .add(Message.fromJson(snapshot.data!.docs[i]));
                    }
                    return ListView.builder(
                      itemBuilder: ((context, index) => email ==
                              messagesList[index].email
                          ? ChatBubble(message: messagesList[index])
                          : ChatBubblForFriend(message: messagesList[index])),
                      itemCount: messagesList.length,
                      controller: _controller,
                      reverse: true,
                    );
                  }
                  return Text("Loading....");
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
              margin: EdgeInsets.all(10.0),
              height: 60.0,
              child: TextField(
                controller: controller,
                onSubmitted: (value) {
                  //print("${value}");
                  messages
                      .add({
                        "message": value,
                        "email": email,
                        'time': DateTime.now(),
                      })
                      .then((value) => print("succes ${value}"))
                      .catchError(
                          (error) => print("Failed to add message: $error"));
                  controller.clear();
                  // _controller.jumpTo(_controller.position.maxScrollExtent);
                  _scrollDown();
                },
                decoration: InputDecoration(
                  hintText: "Send Message",
                  suffixIcon: Icon(
                    Icons.send,
                    color: PrimaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: PrimaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: PrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
