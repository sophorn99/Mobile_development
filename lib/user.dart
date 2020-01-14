import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(User());
class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List users;
  Map userData;
  Future setUser() async {
    String url = "https://reqres.in/api/users";
    http.Response response = await http.get(url);
    userData = json.decode(response.body);
    setState(() {
     users = userData['data']; 
    });
    //can update data
 }
  @override
  void initState(){
    super.initState();
    setUser();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: Text("Information"),
      ),
      body: ListView.builder(  
        itemCount: users == null ? 0: users.length,
        itemBuilder: (BuildContext context, int i){
          return Card(
            child: Container(
              padding: EdgeInsets.all(20.0), 
              child: Row(  
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage("${users[i]["avatar"]}"),
                    
                  ),
                  Container(
                     padding: EdgeInsets.all(20.0), 
                    child: Text("${users[i]["first_name"]}"),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}