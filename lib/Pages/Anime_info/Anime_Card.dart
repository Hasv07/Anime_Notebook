import 'package:flutter/material.dart';

class AnimeinfoCard extends StatelessWidget {
  var data;
  var index;
  var x;
  var title="";
  var value="";
  AnimeinfoCard(this.data, this.index, this.x) {
       title=x[index];
       if(x[index]!="genres"&&x[index]!="episodes"&&x[index]!="popularity"&&x[index]!="rank")
       {
         value=data[title];
       }
       else if(x[index]=="genres")
       {
         var i=0;
         for (var dat in data[title]) {
           if(i>=4)break;
           value+=dat["name"]+" ,";
           i++;
         }
       }
       else
       {
         value=data[title].toString();
       }
  }
  @override
  Widget build(BuildContext context) {
    return  Row(children: [
      Text(
        title+" : ",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      ),
    ]
    );
  }
}
