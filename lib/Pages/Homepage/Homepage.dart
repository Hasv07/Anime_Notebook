import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:project/Pages/Add_Anime/Add_Anime.dart';

import 'dart:convert';

import 'package:project/Pages/Homepage/Anime.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  String anime;
  HomePage(this.anime);

  @override
  _HomePageState createState() => _HomePageState(anime);
}

class _HomePageState extends State<HomePage> {
  // var myText = "Change My Name";

  // TextEditingController _nameController = TextEditingController();

  var url = "https://api.jikan.moe/v3/search/anime?q=";

  String anime;
   var yourAnime;
  var new_data;
  List<dynamic> final_data = List<dynamic>();

  _HomePageState(String anime) {
    read().then((value) {
      if (value != null) {
        yourAnime = value;
      }
      if (anime != null) {
        if (yourAnime == null) {
          yourAnime = List<dynamic>();
          yourAnime.add(anime);
        } else if (!yourAnime.contains(anime)) yourAnime.add(anime);
        new_data = json.encode(yourAnime);
        write();
      }
      fetchData(yourAnime);
    });
  }

  Future<File> write() async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString(new_data);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/yourAnime.json');
  }

  Future<List<dynamic>> read() async {
    final file = await _localFile;
    var data;
    String contents = await file.readAsString();
    if (contents != null) data = json.decode(contents);

    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  fetchData(List<dynamic> youranime) async {
    for (var i = 0; i < youranime.length; i++) {
      var res = await http.get(url + youranime[i]);
      var data1 = jsonDecode(res.body);
      if (res.statusCode == 200&&data1["results"].length>0) {
        final_data.add(data1["results"][0]);
      }
      else 
      {
        youranime.removeAt(i);
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Anime NoteBook"),
        ),
        body: final_data != null
            ? Stack(children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return AnimeCard(final_data, index);
                  },
                  itemCount: final_data.length,
                ),
                Stack(children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      heroTag: "btn_addAnime",
                      onPressed: () {
                        

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Add_Anime()));
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      heroTag: "b",
                      onPressed: () {
                      clear();
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(null)));

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage(null)));
                      },
                      child: Icon(Icons.restore_from_trash),
                    ),
                  )
                ])
              ])
            : Center(child: CircularProgressIndicator()));
  }
  void clear()
  {
    new_data='[]';
    write();
  }
}
