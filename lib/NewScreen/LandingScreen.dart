import 'package:chat_app/NewScreen/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 29.0,
                    color: Colors.teal),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/8,
              ),
              Image.asset("assets/bg.png",color: Colors.greenAccent[700],height: 320,width: 320,),
              SizedBox(
                height: MediaQuery.of(context).size.height/9,
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
                children: [
                  TextSpan(
                    text:'Agree and Continue to accept the',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  TextSpan(
                    text: 'WhatsApp terms of Service and Privacy Policy',
                    style: TextStyle(
                      color: Colors.cyan,
                    ),
                  ),
                ],
              ),
              ),
              ),
              SizedBox(height: 20.0,),
              InkWell(
                onTap: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>LoginPage()), (route) => false);},
                child: Container(
                  width: MediaQuery.of(context).size.width-110,
                  height: 50.0,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 8.0,
                      color: Colors.greenAccent[700],
                    child: Center(
                      child: Text('AGREE AND CONTINUE',
                        style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),),
                    ),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
