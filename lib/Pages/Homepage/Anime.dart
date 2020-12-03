import 'package:flutter/material.dart';
import 'package:project/Pages/Anime_info/Anime_Details.dart';

class AnimeCard extends StatelessWidget {
  var data;
  var index;
  AnimeCard(this.data,this.index);
  @override
  Widget build(BuildContext context) {
    return Card(
      child:Column(children: <Widget>[
      Container(
                
                 height: 100,
                 child: ListTile(

                      title: Text(data[index]["title"]),
                      subtitle: Text(data[index]["synopsis"]),
                        

                      leading: Container(child: Image.network(data[index]["image_url"],fit:BoxFit.cover,))

                    ),
               ),
                  
          Container(
            alignment:Alignment.centerRight,
            child: FloatingActionButton(
              heroTag: "btnl"+index.toString(),
              onPressed: () {
                if(data[index]!=null)
                {
                  Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AnimeDetailsScreen(data[index])));
                }     
              },
      child: Icon(Icons.send),
      
      mini: true,
      ),
      
          ),
   
      ],)
      
      
      
    );
  }
}