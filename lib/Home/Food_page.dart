import 'package:flutter_appcovidhealth2/Models/food.dart';
import 'package:flutter_appcovidhealth2/widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class FoodPage extends StatefulWidget {
  final FoodModel foodModel;
  FoodPage({this.foodModel});

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int foodquantityOfItems = 1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.lightBlue[700]),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
          ),
          title: Text(
            "Dietary",
            style: TextStyle(
                fontSize: 55.0,
                color: Colors.lightBlue[700],
                fontFamily: "Signatra"),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [],
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: ListView(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Image.network(
                          widget.foodModel.ImageURL,
                          width: 250.0,
                          height: 250,
                        ),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: SizedBox(
                          height: 1.0,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title",
                            style: boldTextStyle,
                          ),
                          Text(
                            widget.foodModel.title,
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Ingredients:",
                            style: boldTextStyle,
                          ),
                          Text(
                            widget.foodModel.recipe.toString(),
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Procedure:",
                            style: boldTextStyle,
                          ),
                          Text(
                            widget.foodModel.procedure.toString(),
                            style: boldTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
