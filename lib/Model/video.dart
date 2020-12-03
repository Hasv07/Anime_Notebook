class Video {
   var id;

   var title;

  var  thumbnailUrl;



   Video(Map<String, dynamic> snippet) {
    
      id= snippet['id']['videoId'];
      title= snippet["snippet"]['title'];
      thumbnailUrl= snippet["snippet"]['thumbnails']['high']['url'];
      
    
  }
}
