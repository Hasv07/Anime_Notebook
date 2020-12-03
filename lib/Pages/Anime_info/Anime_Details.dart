import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Model/video.dart';
import 'package:project/Pages/AMV/Amv.dart';
import 'package:project/Pages/AMV/svideoplayer.dart';
import 'package:project/utilities/Key.dart';
import 'dart:convert';

import 'Anime_Card.dart';

class Anime {
  var rating;
  var id;
  var anime_details;
  var req_url = "https://api.jikan.moe/v3/anime/";

  List<String> animeCard = [
    "type",
    "source",
    "episodes",
    "rating",
    "status",
    "rank",
    "popularity",
    "genres"
  ];
  Anime(var anime_info) {
    rating = anime_info["score"];
    id = anime_info["mal_id"];
  }
}

class AnimeDetailsScreen extends StatefulWidget {
  static const routeName = '/Anime-details';
  var anime_info;

  AnimeDetailsScreen(this.anime_info) {}

  @override
  _AnimeDetailsScreenState createState() =>
      _AnimeDetailsScreenState(anime_info);
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  Anime anime;
 String url ="https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=20&q=";
 Video trailer;

  _AnimeDetailsScreenState(var anime_info) {
    anime = Anime(anime_info);
    fetchData();
      url += anime_info["title"] + ' Anime trailer&type=video&key=' + API_KEY;
      fetchvideo();

  }
  fetchData() async {
    var res = await http.get(anime.req_url + anime.id.toString());
    anime.anime_details = jsonDecode(res.body);
    setState(() {});
  }
    fetchvideo() async {
    var res = await http.get(url);
    var data = jsonDecode(res.body);
    if (res.statusCode == 200 && data != null) {
         trailer=Video(data["items"][0]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        // title: Text('Movie Details'),

        backgroundColor: Color(0xfff4f4f4),

        elevation: 0,

        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: anime.anime_details != null
          ? SingleChildScrollView(
               
           child: Column(
                  children: <Widget>[
                    Center(
                      child: Card(
                        elevation: 5,
                        child: Hero(
                          tag: '1',
                          child: Container(
                            height: 450,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  anime.anime_details['image_url'],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      anime.anime_details['title'],
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.timer,
                                  size: 45,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  anime.anime_details['duration'],
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  size: 45,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  anime.anime_details["aired"]["from"]
                                      .substring(0, 4),
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.star_border,
                                  size: 45,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  anime.rating.toString() + '/10',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      anime.anime_details['synopsis'],
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                       SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 340,
                      height: 160,
                      child: Card(
                          
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return AnimeinfoCard(
                                  anime.anime_details, index, anime.animeCard);
                            },
                            itemCount: anime.animeCard.length,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
          )
                    : Center(child: CircularProgressIndicator()),

           bottomNavigationBar: Row(

        children: <Widget>[   Expanded(
                  child: RaisedButton(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    onPressed: () {
                      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreen( trailer.id,trailer.title),
          ));
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.play_circle_outline,
                        ),
                        Text(
                          'Watch Trailer',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomeScreen(anime.anime_details["title"])));},
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.play_circle_outline,
                        ),
                        Container(
                          height: 5,
                          width: 5,
                        ),
                        Text(
                          'AMV',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),

          );
    
  }
}
