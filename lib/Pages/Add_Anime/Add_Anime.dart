
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:project/Pages/Homepage/Homepage.dart';

class Add_Anime extends StatefulWidget {
  final String title = "Add Anime";

  @override
  Add_AnimeState createState() => Add_AnimeState();
}

class   Add_AnimeState extends State<Add_Anime> {
  bool flag;
  var data;
    var txt = TextEditingController();

  var filteredUsers ;
  List<dynamic> between;


  @override
  void initState() {
    super.initState();
    flag = false;
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/json/anime.json'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (!flag) {
                   data = json.decode(snapshot.data.toString());
                   between=data;
                  flag = true;
                }

                return Column(
                children: <Widget>[
                  Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width-50,
                      child: TextField(
                          controller: txt,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            hintText: 'Filter by name',
                          ),
                          onChanged: (string) {
                            setState(() {

                              filteredUsers = between
                                  .where((u) => (u
                                      .toLowerCase()
                                      .contains(string.toLowerCase())))
                                  .toList();
                            });
                          }),
                    ),
                         FloatingActionButton(
                           heroTag:"btn2",
                          onPressed: () {
                                   Navigator.pop(context,
       MaterialPageRoute(builder:( context) => Add_Anime()));
                         Navigator.pop(context,
       MaterialPageRoute(builder:( context) => HomePage(null)));
                           
                              Navigator.push(context,
       MaterialPageRoute(builder:( context) => HomePage((txt.text.length>0)?txt.text:null)));
                           },
                          mini: true,
                          child: Icon(Icons.add),

                  )
                  ],
                  ),
                    Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemCount: filteredUsers == null
                                ? 0
                                : filteredUsers.length,
                            itemBuilder: (BuildContext context, int index) {
                              
                              return GestureDetector(
                             
                             onTap:()=>{txt.text=filteredUsers[index]},
                             child:    Card(
                                
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    filteredUsers[index],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                                
                              )
                             );
                             
                            })),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
