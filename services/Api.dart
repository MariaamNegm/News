import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'news.dart';
class Api{
 final String api_Key="d0f58dea400140a7aeed7feea5611947";
  Future<List<news>> getposts() async {
    //this function is for recieving the data from the server with the address the url
    var url=Uri.parse("https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=d0f58dea400140a7aeed7feea5611947");
    var response= await http.get(url);
    // define a list to carry the data
    List<news> listposts=[];
    if(response.statusCode==200){
      print("status ok");
// status code 200 means that the data is responding and found
      var responsebody=jsonDecode(response.body) ;

      for(var i in responsebody)
      {
        //looping for saving the data in the list
        news post=news(title: i["title"],description: i["description"],url: i["url"], urlToImage: i["urlToImage"]);
        listposts.add(post);
      }
      return  listposts;

    }
    return  listposts;
  }
  Future<List<news>> getpostsbycat(String Cat) async {
   //this function is for recieving the data from the server with the address the url
   var url=Uri.parse(" https://newsapi.org/v2/top-headlines?country=eg&category=$Cat&apiKey=d0f58dea400140a7aeed7feea5611947");
   var response= await http.get(url);
   // define a list to carry the data
   List<news> listposts=[];
   if(response.statusCode==200){
// status code 200 means that the data is responding and found
     var responsebody=jsonDecode(response.body) ;

     for(var i in responsebody)
     {
       //looping for saving the data in the list
       news post=news(title: i["title"],description: i["description"],url: i["url"], urlToImage: i["urlToImage"]);
       listposts.add(post);
     }
     return  listposts;

   }
   return  listposts;
 }
}