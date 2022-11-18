
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});


  @override
  Widget build(BuildContext context) {
    return AppBar(
    iconTheme: IconThemeData(
      color: Colors.lightBlue[700],
    ),
      flexibleSpace: Container(
        decoration: new BoxDecoration(


          color: Colors.white,



        ),
      ),
      title: Text(
        "CovidHealthTech",
        style: TextStyle(fontSize: 50,color: Colors.lightBlue[700],fontFamily: "Signatra",),
      ),
      centerTitle: true,
      bottom: bottom,
     actions: [
      ],
    );
  }


  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
