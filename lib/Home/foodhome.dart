import 'dart:async';

import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Home/Fooddinner.dart';
import 'package:flutter_appcovidhealth2/Home/food.dart';
import 'package:flutter_appcovidhealth2/Home/foodSnack.dart';
import 'package:flutter_appcovidhealth2/Home/foodlunch.dart';
import 'package:flutter_appcovidhealth2/Models/food.dart';
import 'package:flutter_appcovidhealth2/counter/fooditemcounter.dart';
import 'package:flutter_appcovidhealth2/widgets/foodSearchbox.dart';
import 'package:flutter_appcovidhealth2/widgets/loadWidget.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'Food_page.dart';
import 'foodfav.dart';

double width;

class Foodhome extends StatefulWidget {
  @override
  _FoodhomeState createState() => _FoodhomeState();
}

class _FoodhomeState extends State<Foodhome> {
  DateTime backButtonPressed;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
              children: [
                IconButton(
                  icon: Icon(
                    EvaIcons.questionMark,
                    color: Colors.lightBlue[700],
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            content: Container(
                              height: 500,
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                semanticContainer: true,
                                child: Image.asset(
                                  'images/dietary.jpg',
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.all(10),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: Center(
            child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 400,
              height: 100,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (_) => Food());
                  Navigator.pushReplacement(context, route);
                },
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        "images/Picture2.png",
                        width: 140,
                        height: 110,
                      ),
                      Text(
                        'Breakfast',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.lightBlue[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 400,
              height: 100,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (_) => FoodLunch());
                  Navigator.pushReplacement(context, route);
                },
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        "images/Picture7.png",
                        width: 140,
                        height: 110,
                      ),
                      Text(
                        'Lunch',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.lightBlue[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 400,
              height: 100,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (_) => FoodSnack());
                  Navigator.pushReplacement(context, route);
                },
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        "images/Picture12.png",
                        width: 140,
                        height: 110,
                      ),
                      Text(
                        'SnackTime',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.lightBlue[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 400,
              height: 100,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (_) => FoodDinner());
                  Navigator.pushReplacement(context, route);
                },
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        "images/Picture16.png",
                        width: 140,
                        height: 110,
                      ),
                      Text(
                        'Dinner',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.lightBlue[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

Widget sourceInfo(FoodModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route route =
          MaterialPageRoute(builder: (c) => FoodPage(foodModel: model));
      Navigator.pushReplacement(context, route);
    },
    splashColor: Colors.lightBlue[700],
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
        height: 190.0,
        width: width,
        child: Row(
          children: [
            Image.network(
              model.ImageURL,
              width: 140.0,
              height: 140.0,
            ),
            SizedBox(
              width: 4.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            "",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            "",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Row(
                              children: [
                                Text(
                                  model.title,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  model.classification,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16.0),
                                ),
                                Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Flexible(
                    child: Container(),
                  ),

                  //to implement the cart item aad/remove feature
                  Align(
                    alignment: Alignment.centerRight,
                    child: removeCartFunction == null
                        ? IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.lightBlue[700],
                            ),
                            onPressed: () {
                              checkItemInCart(model.title, context);
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              removeCartFunction();
                              Route route =
                                  MaterialPageRoute(builder: (c) => FoodFav());
                              Navigator.pushReplacement(context, route);
                            },
                          ),
                  ),

                  Divider(
                    height: 5.0,
                    color: Colors.lightBlue[700],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.white, String imgPath}) {
  return Container(
    height: 150.0,
    width: width * .34,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 5), blurRadius: 10.0, color: Colors.grey[200]),
        ]),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Image.network(
        imgPath,
        height: 150.0,
        width: width * .34,
        fit: BoxFit.fill,
      ),
    ),
  );
}

void checkItemInCart(String titleAsID, BuildContext context) {
  HealthApp.sharedPreferences
          .getStringList(HealthApp.userFoodCartList)
          .contains(titleAsID)
      ? Fluttertoast.showToast(msg: "Menu is already in Favorites.")
      : addItemToCart(titleAsID, context);
}

addItemToCart(String titleAsID, BuildContext context) {
  List tempCartList =
      HealthApp.sharedPreferences.getStringList(HealthApp.userFoodCartList);
  tempCartList.add(titleAsID);

  HealthApp.firestore
      .collection(HealthApp.collectionUser)
      .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
      .updateData({
    HealthApp.userFoodCartList: tempCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Menu Added to Favorites Successfully.");

    HealthApp.sharedPreferences
        .setStringList(HealthApp.userFoodCartList, tempCartList);

    Provider.of<FoodCounter>(context, listen: false).displayResult();
  });
}
