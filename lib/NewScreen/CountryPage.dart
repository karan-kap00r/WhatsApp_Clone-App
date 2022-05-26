import 'package:chat_app/Model/CountryModel.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key, required this.setCountryData}) : super(key: key);
  final Function setCountryData;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {



  List<CountryModel> countries=[
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){Navigator.pop(context);},
            child: Icon(
          Icons.arrow_back,
          color: Colors.teal,
        )),
        title: Text(
          'Choose a country',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            wordSpacing: 1.0,
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.teal,))
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
          itemBuilder: (context,index)=>card(countries[index])),
    );
  }

  Widget card(CountryModel country){
    return InkWell(
      onTap: (){widget.setCountryData(country);},
      child: Card(
      margin: EdgeInsets.all(0.15),

        child: Container(height: 60,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: Row(
          children: [
            Text(country.flag),
            SizedBox(width: 15,),
            Text(country.name),
            
            Expanded(
              child: Container(
                width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(country.code),
                    ],
                  )),
            ),
          ],
        ),
        ),
      ),
    );
  }

}
