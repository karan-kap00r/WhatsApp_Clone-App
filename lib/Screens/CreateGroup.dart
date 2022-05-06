import 'package:chat_app/CustomUI/AvtarCard.dart';
import 'package:chat_app/CustomUI/ContactCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "MS Dhoni", status: "A full stack developer",id: 10),
    ChatModel(name: "Virat Kohli", status: "Flutter Developer...........",id: 11),
    ChatModel(name: "Rohit Sharma", status: "Web developer...",id: 12),
    ChatModel(name: "Rituraj", status: "App developer....",id: 13),
    ChatModel(name: "ABD", status: "Raect developer..",id: 14),
    ChatModel(name: "KL Rahul", status: "Full Stack Web",id: 15),
    ChatModel(name: "Mohammad Shami", status: "Example work",id: 16),
    ChatModel(name: "Mayank Agarwal", status: "Sharing is caring",id: 17),
    ChatModel(name: "Bens Stocks", status: ".....",id: 18),
    ChatModel(name: "SKY", status: "Love you Mom Dad",id: 19),
    ChatModel(name: "R Ashwin", status: "I find the bugs",id: 20),
  ];
  List<ChatModel> groupmember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Add participants",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF128C7E),
            onPressed: () {},
            child: Icon(Icons.arrow_forward)),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: groupmember.length > 0 ? 90 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (contacts[index - 1].select == true) {
                          groupmember.remove(contacts[index - 1]);
                          contacts[index - 1].select = false;
                        } else {
                          groupmember.add(contacts[index - 1]);
                          contacts[index - 1].select = true;
                        }
                      });
                    },
                    child: ContactCard(
                      contact: contacts[index - 1],
                    ),
                  );
                }),
            groupmember.length > 0
                ? Align(
              child: Column(
                children: [
                  Container(
                    height: 75,
                    color: Colors.white,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].select == true)
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  groupmember.remove(contacts[index]);
                                  contacts[index].select = false;
                                });
                              },
                              child: AvatarCard(
                                chatModel: contacts[index],
                              ),
                            );
                          return Container();
                        }),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
              alignment: Alignment.topCenter,
            )
                : Container(),
          ],
        ));
  }
}