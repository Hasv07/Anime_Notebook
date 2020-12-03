import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/Model/video.dart';
import 'package:project/Pages/AMV/svideoplayer.dart';
import 'package:project/utilities/Key.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  String anime;
  HomeScreen(this.anime);
  _HomeScreenState createState() => _HomeScreenState(anime);
}

class _HomeScreenState extends State<HomeScreen> {
  String url =
      "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=20&q=";
  List<Video> videos =List<Video>();

  bool _isLoading = false;
  _HomeScreenState(String anime) {
    url += anime + 'AMV&type=video&key=' + API_KEY;
    fetchData();
  }
  fetchData() async {
    var res = await http.get(url);
    var data = jsonDecode(res.body);
    if (res.statusCode == 200 && data != null) {
      for (var dat in data["items"]) {
        videos.add(Video(dat));
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  _buildVideo(Video video) {
    return Card(
        child: Column(children: [
      Text(
        video.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 20,
      ),
      GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreen(video.id,video.title),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          padding: EdgeInsets.all(10.0),
          height: 140.0,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Image(
                width: 150.0,
                image: NetworkImage(video.thumbnailUrl),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  video.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AMV'),
      ),
      body: videos != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                Video video = videos[index];

                return _buildVideo(video);
              },
              itemCount: videos.length,
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
    );
  }
}
