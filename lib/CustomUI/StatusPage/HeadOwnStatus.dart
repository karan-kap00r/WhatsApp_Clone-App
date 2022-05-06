import 'package:flutter/material.dart';

class HeadOwnStatus extends StatelessWidget {
  const HeadOwnStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
      children: [
        CircleAvatar(
          radius: 27.0,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/2.png"),
        ),
        Positioned(right: 0,bottom: 0,
          child: CircleAvatar(
            radius: 11.0,
              child: Icon(Icons.add,size: 20.0,color: Colors.white,),
            backgroundColor: Colors.greenAccent[700],
          ),
        )
      ],
      ),
      title: Text("My Status",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
      subtitle: Text("Tap to add status update",style: TextStyle(fontSize: 13.0,color: Colors.grey[900]),),

    );
  }
}
