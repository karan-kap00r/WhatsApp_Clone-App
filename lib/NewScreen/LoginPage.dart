import 'package:chat_app/Model/CountryModel.dart';
import 'package:chat_app/NewScreen/AuthService.dart';
import 'package:chat_app/NewScreen/CountryPage.dart';
import 'package:chat_app/NewScreen/OtpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryName = "India";
  String countryCode = "+91";

  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";

  TextEditingController _controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Enter your phone number',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            wordSpacing: 1.0,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Icon(Icons.more_vert, color: Colors.black),
        ],
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [

            Text("WhatsApp will send an sms message to verify your number",
                style: TextStyle(fontSize: 13.5)),
            SizedBox(
              height: 5,
            ),
            Text("What's my number?",
                style: TextStyle(fontSize: 13.5, color: Colors.cyan[800])),
            SizedBox(
              height: 15,
            ),
            countryCard(),
            SizedBox(
              height: 15,
            ),
            number(),
            Expanded(child: Container()),
            InkWell(
              onTap: (){
                if(_controller.text.length<10)
                  {
                    showMyDialog1();
                  }
                else
                  {
                    showMyDialog();
                  }
              },
              child: Container(
                height: 40,
                width: 70,
                color: Colors.tealAccent[400],
                child: Center(
                  child: Text("NEXT",style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),),
                ),
              ),
            ),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => CountryPage(
                      setCountryData: setCountryData,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.teal,
            width: 1.8,
          )),
        ),
        child: Row(
          children: [
            Expanded(
                child: Container(
                    child: Center(
                        child: Text(countryName,
                            style: TextStyle(fontSize: 16))))),
            Icon(Icons.arrow_drop_down, color: Colors.teal)
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width/1.5,
      height: 38,
      child: Row(
        children: [
           Container(
              width: 239,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                )),
              ),
               child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text("+",style: TextStyle(fontSize: 16)),
                      SizedBox(width: 20,),
                      Text(countryCode.substring(1),
                          style: TextStyle(fontSize: 16)
                      ),
                      SizedBox(
                        width: 15,
                      ),
                       Container(
                            width: MediaQuery.of(context).size.width/1.5-100,
                            // decoration: BoxDecoration(
                            //   border: Border(
                            //       bottom: BorderSide(
                            //         color: Colors.teal,
                            //         width: 1.8,
                            //       )),
                            // ),
                            child: TextFormField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(8),
                                hintText: "phone number"
                              ),
                            ),
                          ),
                    ],
                  ),
              //   ),
              // ),
            ),
        ],
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name;
      countryCode = countryModel.code;
    });
    Navigator.pop(context);
  }
  
  Future<void> showMyDialog(){
    return showDialog(context: context, builder: (buildContext){
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('We will be verifying your phone number',style: TextStyle(fontSize: 14),),
              SizedBox(height: 10,),
              Text(countryCode +" "+ _controller.text,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
              SizedBox(height: 10,),
              Text('Is this OK or would you like to edit the number?',style: TextStyle(fontSize: 13.5),),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Edit')),
          TextButton(onPressed: () async {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>OtpScreen(countryCode: countryCode,number: _controller.text,)));
            // await authClass.verifyPhoneNumber(
            //     "${_controller.text}", context, setData);
            }, child: Text('OK')),
        ],
      );
    });
  }

  Future<void> showMyDialog1(){
    return showDialog(context: context, builder: (buildContext){
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('There is no number you have entered',style: TextStyle(fontSize: 14),),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){Navigator.pop(context);}, child: Text('OK')),
        ],
      );
    });
  }
  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    // startTimer();
  }

}
