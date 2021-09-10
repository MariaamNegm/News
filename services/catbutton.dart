 import 'package:flutter/material.dart';
import 'package:selfimprovmentapp/screens/catpage.dart';
class catbutton extends StatefulWidget {

  String name_cat;
  catbutton(this.name_cat);

  @override
  _catbuttonState createState() => _catbuttonState();
}

class _catbuttonState extends State<catbutton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: FlatButton(

          color:Colors.deepOrange,
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(50)
          ),
          onPressed:()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>catpage(widget.name_cat)));
            print("hi");
          }, child:
      Text("${widget.name_cat}",style: TextStyle(fontSize:20,color:Colors.white),textAlign:TextAlign.center,)
      ),
    );
  }
}
