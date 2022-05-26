import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          callCard("Tajinder","assets/3.jpg",Icons.call_made,Colors.green,"Today 10:35 pm"),
          callCard("Saku","assets/saku.jpg",Icons.call_made,Colors.green,"Today 02:10 pm"),
          callCard("Navu","assets/navu.jpg",Icons.call_received,Colors.green,"Yesterday 09:46 am"),
          callCard("Kriti","assets/kriti.jpg",Icons.call_missed,Colors.red,"Yesterday 11:13 am"),
          callCard("Sukh","assets/nitu.jpg",Icons.call_received,Colors.green,"17 May 10:22 pm"),
          callCard("Saku","assets/saku.jpg",Icons.call_missed,Colors.red,"16 May 04:47 pm"),
        ],
      ),
      floatingActionButton: CircleAvatar(
        radius: 26,
        child: Icon(Icons.add_call,size: 35,color: Colors.white,),
      backgroundColor:Colors.teal[600],),
    );
  }
  Widget callCard(String name,String Avatar,IconData iconData,Color iconColor,String time){
    return Card(
      margin: EdgeInsets.only(bottom: 0.5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(Avatar),
          radius: 26,
        ),
        title: Text(name,style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Row(
          children: [
            Icon(iconData,color: iconColor,size: 20,),
            SizedBox(width: 6,),
            Text(time,style: TextStyle(fontSize: 12.8),),
          ],
        ),
        trailing: Icon(Icons.call,size: 28,color: Colors.teal,),
        ),
    );
}
}
