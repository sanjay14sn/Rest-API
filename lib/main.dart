import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main (){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner:false,
        home: MyApp(),
      )
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List Data =[];

  Future<void> fetchdata() async {
    final res = await http.get(Uri.parse("https://reqres.in/api/users?page=1"));
    print("API");
    print(res.body.toString());

    setState(() {
      Data   = json.decode(res.body)['data'];
    });


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.blue,
        actions: [],
        title: Text("API"),),
      body: ListView.builder(itemCount:Data.length,
        itemBuilder:(context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(Data[index]['avatar']),
            ),
            title: Text(Data[index]['first_name'],style:TextStyle(
                fontSize:20,fontWeight:FontWeight.bold
            ),),
            subtitle: Text(Data[index]['email'],style:TextStyle(
                fontSize:15,fontStyle: FontStyle.italic)),

          );
        },),
    );
  }
}
