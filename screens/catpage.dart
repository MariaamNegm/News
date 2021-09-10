import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfimprovmentapp/services//Api.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
class catpage extends StatefulWidget {
  String cat ;
  catpage(this.cat);
  @override
  _catpageState createState() => _catpageState();
}
// this class is for the category pages by clicking on the category you want
class _catpageState extends State<catpage> {
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
    Api api=Api();
    return  Scaffold(
      backgroundColor: Color.fromRGBO(189, 226, 151, 1),
      body:  Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    alignment: Alignment.topRight,
                    onPressed:(){
                      Navigator.pop(context);
                    }, icon:Icon(Icons.arrow_back_ios , color:Colors.black87,size: 30,)),
                Text("${widget.cat} News",style: TextStyle(fontSize:22,color: Colors.black87)),
              ],
            ),
          ),

          Container(
            height: 400,
            color: Colors.teal,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(8),
            child: FutureBuilder(
              future:api.getpostsbycat(widget.cat),
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
                                //checking that the image data is not null
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
