import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Pages/IndividualPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key,required this.chatModel, required this.sourchat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualPage(
          chatModel: chatModel,
          sourchat: sourchat,
        )));
      },
      child: Column(
        children: [
          ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.grey[400],
            child:SvgPicture.asset(
              (chatModel.isGroup?? false)?"assets/groups.svg":"assets/person.svg",
            color: Colors.teal[800],
              height: 37.0,
              width: 37.0,
            ),

          ),
            title: Text(chatModel.name!,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),),
              subtitle: Row(
              children: [
                Icon(Icons.done_all),
          SizedBox(width: 3.0,),
          Text(chatModel.currentMessage!,
          style: TextStyle(
          fontSize: 13.0,
          ),
          ),
            ],
          ),
            trailing: Text(chatModel.time!),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 80.0),
            child: Divider(thickness: 1.0,),
          ),
        ],
      ),
    );
  }
}
