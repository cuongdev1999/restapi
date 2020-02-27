import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(MaterialApp(

  home: HomePage(),
));

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return HomePageState();
  }

}
class HomePageState extends State<HomePage>{

  List data;




  Future<String> fetchAlbum() async{
    final response= await http.get(Uri.encodeFull(url),
        headers: {
        "Accept" : "application/json"
        }
    );
    if(response.statusCode == 200){
      setState(() {
        data = jsonDecode(response.body);
        print(data);
      });


    }else{
      throw Exception(response.statusCode);

    }




  }



  Future<Album> futureAlbum;



//  @override
//  void initState() {
//
//    super.initState();
//    futureAlbum = fetchAlbum();
//  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        title: Text('HomePage'),
      ),
      body: SingleChildScrollView(
       child:Container(
         height: 1000,
         width: 800,
         child: ListView.builder(
             itemCount: data ==null ? 0 : data.length,
             itemBuilder: (BuildContext  context, int index){
               return new Container(
                 height: 100,
                 child: new Column(
                   children: <Widget>[
                     GestureDetector(
                       onTap: (){
                         print(index);
                       },
                       child:Row (
                         children: <Widget>[
                           Flexible(
                             flex: 2,
                             child: Text('UserID:${data[index]['userId']}',),
                           ),
                           Flexible(
                             flex: 2,
                             child: Text('ID:${data[index]['id']}'),
                           ),
                           Flexible(
                             flex: 6,
                             child: Text('Title:${data[index]['title']}'),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),

               );

             }),
       )

      ),
      floatingActionButton: IconButton(
      icon: Icon(Icons.add_circle,color: Colors.red,),
      onPressed: (){
        setState(() {
          fetchAlbum();
        });
      },
    ),
    );
  }

}

final String url = 'https://jsonplaceholder.typicode.com/albums';

class Album{
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String,dynamic> json){
    return Album(
      userId : json['userId'],
      id: json['id'],
      title: json['title'],
    );

  }

}


