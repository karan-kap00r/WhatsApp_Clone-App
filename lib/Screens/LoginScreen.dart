import 'package:chat_app/CustomUI/ButtonCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatmodels=[
    ChatModel(
      name: "Karan",
      isGroup: false,
      time: "4:00",
      currentMessage: "Hey there..",
      icon: "person",
      id: 1,
    ),
    ChatModel(
      name: "Navu",
      isGroup: false,
      time: "4:50",
      currentMessage: "Hey buddy",
      icon: "person",
      id: 2,
    ),
    ChatModel(
      name: "Saku",
      isGroup: false,
      time: "6:10",
      currentMessage: "Kaise ho..?",
      icon: "person",
      id: 3,
    ),
    ChatModel(
      name: "Nitu",
      isGroup: false,
      time: "4:08",
      currentMessage: "Shit..",
      icon: "person",
      id: 4,
    ),
    ChatModel(
      name: "Kriti",
      isGroup: false,
      time: "4:08",
      currentMessage: "Excuse Me!",
      icon: "person",
      id: 5,
    ),
    ChatModel(
      name: "NKS",
      isGroup: true,
      time: "9:40",
      currentMessage: "Hey guys",
      icon: "groups",
      id: 6,
    ),
    ChatModel(
      name: "RBIENT",
      isGroup: true,
      time: "8:16",
      currentMessage: "Me here",
      icon: "groups",
      id: 7,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (contex, index) => InkWell(
            onTap: () {
              sourceChat = chatmodels.removeAt(index);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => HomeScreen(
                        chatmodels: chatmodels,
                        sourchat: sourceChat,

                      )));
            },
            child: ButtonCard(
              name: chatmodels[index].name??"",
              icon: Icons.person,
            ),
          )),
    );
  }
}
