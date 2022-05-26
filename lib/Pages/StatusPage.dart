import 'package:chat_app/CustomUI/StatusPage/HeadOwnStatus.dart';
import 'package:chat_app/CustomUI/StatusPage/OthersStatus.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48.0,
            child: FloatingActionButton(
                backgroundColor: Colors.blueGrey[100],
                elevation: 8,
                onPressed: () {},
                child: Icon(
                  Icons.edit,
                  color: Colors.blueGrey[900],
                )),
          ),
          SizedBox(
            height: 13.0,
          ),
          FloatingActionButton(
              backgroundColor: Colors.greenAccent[700],
              elevation: 5,
              onPressed: () {},
              child: Icon(
                Icons.camera_alt,
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          HeadOwnStatus(),
          Label("Recent updates"),
          OthersStatus(
            time: '11:11 AM',
            imageName: 'assets/navu.jpg',
            name: 'Navu',
            statusNum: 2,
            isSeen: false,
          ),
          OthersStatus(
            time: '11:40 AM',
            imageName: 'assets/saku.jpg',
            name: 'Saku',
              statusNum: 1,
              isSeen: false,
          ),
          OthersStatus(
            time: '01:10 PM',
            imageName: 'assets/kriti.jpg',
            name: 'Kriti',
              statusNum: 4,
              isSeen: false,
          ),
          SizedBox(
            height: 10.0,
          ),
          Label("Viewed updates"),
          OthersStatus(
            time: '04:30 PM',
            imageName: 'assets/nitu.jpg',
            name: 'Nitu',
              statusNum: 1,
              isSeen: true,
          ),
          OthersStatus(
            time: '06:20 PM',
            imageName: 'assets/3.jpg',
            name: 'Sukh',
            statusNum: 3,
            isSeen: true,
          ),
        ],
      )),
    );
  }

  Widget Label(String LabelName) {
    return Container(
      height: 33.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 7.0),
        child: Text(
          LabelName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }
}
