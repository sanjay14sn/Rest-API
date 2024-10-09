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
  List data =[];
  Future<void> fetchdata() async{
    final res = await http.get(Uri.parse("https://retoolapi.dev/gTJd0N/data"));

   // print(res.body.toString());
    setState(() { data = jsonDecode(res.body);

    });

    print(data.toString());
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
        backgroundColor: Colors.yellow,
        title:Text("USER DETAIL"),
        actions: [IconButton(onPressed: (){
          print("working");}, icon: Icon(Icons.add))],
      ),
      body:ListView.builder(itemCount:data.length,
    itemBuilder: (context,index){
        return Padding(
          padding: EdgeInsets.all(9.0),
        child: Container(
        height: 150,
        width: double.infinity,
        color:Colors.blue,
        child: Row(
          children: [
            Column(children: [
              Container(
                height:150,
                width:150,
                decoration: BoxDecoration(
                  color:Colors.white,
                  image: DecorationImage
                    (image: NetworkImage(data[index]['Logo']),
                    fit: BoxFit.cover,

                  ),
                ),

              )
            ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(data[index]["Name"],
                    style:TextStyle(fontWeight:FontWeight.bold),),
                  Text(data[index]["Email"]),
                  Text(data[index]["Phone"]),
                  Text(data[index]["Rating"])


                ],
              ),
            )
          ],
        ),),



        );
    } ),
    );
  }
}
