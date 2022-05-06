import 'package:chat_app/CustomUI/OwnMessageCard.dart';
import 'package:chat_app/CustomUI/ReplyCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Model/MessageModel.dart';
import 'package:emoji_picker_2/emoji_picker_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class IndividualPage extends StatefulWidget {
  IndividualPage({Key? key, required this.chatModel, required this.sourchat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;


  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  TextEditingController _controller = TextEditingController();
  List<MessageModel> messages = [];
  ScrollController _scrollController = ScrollController();
  late final IO.Socket _socket;

  @override
  void initState() {
    super.initState();
    connect();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    // connect();
  }

  IO.Socket get socket {
    if (!isConnected) {
      connect();
    }
    return _socket;
  }

  bool get isConnected {
    return _socket != null;
  }

  Future<void> connect() async {
    _socket = await IO.io(
        'http://192.168.43.244:5000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
        // .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    await _socket.connect();
    _socket.emit('signin', widget.sourchat.id);
    _socket.onConnect((data) { print('Connected!');

    });
    _socket.on('message', (data) {
      print(data);

      setMessage("destination", data["message"]);
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
    print(_socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }


  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/whatsapp_Back.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.teal[800],
              leadingWidth: 70.0,
              titleSpacing: 0.0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        (widget.chatModel.isGroup ?? false)
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        color: Colors.teal[800],
                        height: 37.0,
                        width: 37.0,
                      ),
                      radius: 20.0,
                      backgroundColor: Colors.grey[400],
                    )
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name ?? "",
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Last seen today at ${widget.chatModel.time} am",
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.video_camera_back)),
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      child: Text("View Contact"),
                      value: "View Contact",
                    ),
                    PopupMenuItem(
                      child: Text("Media, Links & Docs"),
                      value: "Media, Links & Docs",
                    ),
                    PopupMenuItem(
                      child: Text("WhatsApp Web"),
                      value: "WhatsApp Web",
                    ),
                    PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                    PopupMenuItem(
                      child: Text("Mute Notification"),
                      value: "Mute Notification",
                    ),
                    PopupMenuItem(
                      child: Text("Wallpaper"),
                      value: "Wallpaper",
                    ),
                  ],
                ),
              ],
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: WillPopScope(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: messages.length + 1,
                            itemBuilder: (context, index) {
                              if (index == messages.length) {
                                return Container(
                                  height: 70,
                                );
                              }
                              if (messages[index].type == "source") {
                                return OwnMessageCard(
                                  message: messages[index].message,
                                  time: messages[index].time,
                                );
                              } else {
                                return ReplyCard(
                                  message: messages[index].message,
                                  time: messages[index].time,
                                );
                              }
                            },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                      margin:
                                          EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0)),
                                      child: TextFormField(
                                        focusNode: focusNode,
                                        controller: _controller,
                                        textAlignVertical: TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 1,
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            setState(() {
                                              sendButton = true;
                                            });
                                          } else {
                                            setState(() {
                                              sendButton = false;
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: ("Type a message"),
                                          prefixIcon: IconButton(
                                            icon: Icon(Icons.emoji_emotions,color: Colors.grey[600],),
                                            onPressed: () {
                                              if (!show) {
                                                focusNode.unfocus();
                                                focusNode.canRequestFocus = false;
                                              }
                                              setState(() {
                                                show = !show;
                                              });
                                            },
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.attach_file,color: Colors.grey[600],),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    backgroundColor:
                                                    Colors.transparent,
                                                    context: context,
                                                    builder: (builder) =>
                                                        bottomSheet());},
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.camera_alt,color: Colors.grey[600],),
                                                onPressed: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (builder) =>
                                                  //             CameraApp()));
                                                },
                                              ),
                                            ],
                                          ),
                                          contentPadding: EdgeInsets.all(5.0),

                                        ),
                                      )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0,right: 5.0,left: 2.0),
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFF128C7E),
                                    child: IconButton(
                                        icon: Icon(
                                          sendButton ? Icons.send : Icons.mic,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          if (sendButton) {
                                            _scrollController.animateTo(
                                                _scrollController
                                                    .position.maxScrollExtent,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut);
                                            sendMessage(
                                                _controller.text,
                                                widget.sourchat.id,
                                                widget.chatModel.id);
                                            _controller.clear();
                                            setState(() {
                                              sendButton = false;
                                            });
                                          }
                                        },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            show? emojiSelect():Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onWillPop: () {
                    if (show) {
                      setState(() {
                        show = false;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                    return Future.value(false);
                  },
                ),
            ),
        ),
      ],
    );
  }
  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
  return EmojiPicker2(onEmojiSelected: (emoji, category){
    rows: 4;
    columns: 7;
    print(emoji);
    setState(() {
      _controller.text = _controller.text + emoji.emoji;
    });
  });
  }
}
