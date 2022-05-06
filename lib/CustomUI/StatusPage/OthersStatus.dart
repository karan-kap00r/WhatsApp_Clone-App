import 'package:flutter/material.dart';

class OthersStatus extends StatelessWidget {
  const OthersStatus({Key? key, required this.imageName, required this.time, required this.name}) : super(key: key);
  final String imageName;
  final String time;
  final String name;

  @override
  Widget build(BuildContext context) {
    return
        ListTile(
        leading:  CircleAvatar(
          radius: 27.0,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(imageName),
        ),
            title: Text(name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
            subtitle: Text("Today, ${time} AM",style: TextStyle(fontSize: 13.0,color: Colors.grey[900]),),
        );

  }
}
