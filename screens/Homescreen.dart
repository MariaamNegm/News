import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfimprovmentapp/services/Api.dart';
import 'package:selfimprovmentapp/services/catbutton.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //function for opening a link on a browser
  //by taking the url as a parameter for the function processing
  Future<void>openlink(String link)async{
    if(await canLaunch(link))
      {
        await launch(link);
      }
    else
      {
        await launch(link);
      }
  }
  @override
  Widget build(BuildContext context) {
    // an object from class api which has the methods responsible for getting the data
    Api api=Api();
    return Scaffold(
      backgroundColor: Color.fromRGBO(189, 226, 151, 1),
      body:  Column(
        children: [
          // a title for the page on a card
              Card(
                elevation: 30,
                color: Color.fromRGBO(242, 238, 108, 1),
                shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(30),
                ),
                margin: EdgeInsets.only( top: 8),
                child: Container(
                  height: 44,
                  width: 400,
                  margin:EdgeInsets.all(4),
                  alignment: Alignment.topLeft,
                  child: Text("  NewsPapper_News ",style: TextStyle(
                      color: Colors.black87,fontSize: 35
                  ),  ),
                ),
              ),
              //this container is carrying the listview as a bar holding the different categories
              Container(
                height: 100,
                padding: EdgeInsets.all(5),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(5.0),
                  children: [
                    //objects from the class catbutton carrying the name of the category(constructor)
                    catbutton("health"),
                    catbutton("sports"),
                    catbutton("science"),
                    catbutton("business"),
                  ],
                ),
              ),
              // title saying thst this screen holds general news not the specific categorey
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("General News",style: TextStyle(fontSize:22,color: Colors.black87)),
                  ],
                ),
              ),
              //this is the listview carrying the news on a card , each car has share button and an image and text
              Container(
            height: 400,
            color: Colors.teal,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(8),
                child: FutureBuilder(
                  future:api.getposts(),
                  //calling the function of getposts as it is the api responsible for getting the data
                  builder: (BuildContext context, AsyncSnapshot<dynamic>snapshot) {
                    if (snapshot.data==null) {
                      //checking if there is data or not
                      return Center(
                        //if the data is not found so the progress indicator will be displayed
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black87,

                        ),
                      );
                    }

                    else {print("hi i am here");
                      return ListView.builder(
                        //the length it depends on how much data handled
                          itemCount:snapshot.data.length,
                          //context is where you are in the code instantly and i is the index
                          itemBuilder:(context,i)
                          {
                            return GestureDetector(
                                onTap :(){
                                  openlink("${snapshot.data[i].url}");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                                  ),
                                  elevation: 20.0,
                                  child: Column(
                                    children: [
                                      Image.network(("${snapshot.data[i].urlToImage}" ==null)?"https://www.google.com/url?sa=i&url=https%3A%2F%2Fthenounproject.com%2Fterm%2Fimage-error%2F504708%2F&psig=AOvVaw0Zp2tMFjjlvioVamwgna3y&ust=1631339249190000&source=images&cd=vfe&ved=2ahUKEwjYyfW02vPyAhWJ0oUKHY3MAEMQr4kDegUIARDHAQ" :"${snapshot.data[i].urlToImage}",height:220,fit: BoxFit.cover, ),
                                      Row(
                                        children: [
                                          Text("${snapshot.data[i].title}" ,style: TextStyle(
                                              fontSize: 30
                                          ),),
                                          IconButton(onPressed:(){
                                            Share.share("${snapshot.data[i].url}");
                                          }, icon:Icon(Icons.share ,size: 30,),color:Colors.black87, )
                                        ],
                                      ),

                                    ],
                                  ),


                                ));
                          }
                      );

                    }
                  },
                ),
          ),
        ],
      ),
    );
  }
}
