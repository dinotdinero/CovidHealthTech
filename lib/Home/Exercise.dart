import 'dart:async';

import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Home/ItemFav.dart';
import 'package:flutter_appcovidhealth2/Home/product_page.dart';
import 'package:flutter_appcovidhealth2/Models/item.dart';
import 'package:flutter_appcovidhealth2/counter/itemcounter.dart';
import 'package:flutter_appcovidhealth2/counter/totalMoney.dart';
import 'package:flutter_appcovidhealth2/widgets/loadWidget.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:flutter_appcovidhealth2/widgets/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'ItemFav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'food.dart';
import 'homemenu.dart';

double width;

class Exercise extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _Exercisestate createState() => _Exercisestate();
}

class _Exercisestate extends State<Exercise> {
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
          "Exercise",
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
                              child: Image.asset(
                                'images/exercise1.jpg',
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
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("exercises")
                  .orderBy("title", descending: true)
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          ItemModel model = ItemModel.fromJson(
                              dataSnapshot.data.documents[index].data);
                          return sourceInfo(model, context);
                        },
                        itemCount: dataSnapshot.data.documents.length,
                      );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Go to Favorite Exercises",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue[700],
        icon: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        onPressed: () {
          Route route = MaterialPageRoute(builder: (c) => CartPage());
          Navigator.pushReplacement(context, route);
        },
      ),
    ));
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
      onTap: () {
        Route route =
            MaterialPageRoute(builder: (c) => ProductPage(itemModel: model));
        Navigator.pushReplacement(context, route);
      },
      splashColor: Colors.lightBlue[700],
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          height: 190.0,
          width: width,
          child: Center(
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.network(
                    model.ImageURL,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      model.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black,
                          fontSize: 30.0),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 60),
                    child: Text(
                      model.typeofExercise,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black,
                          fontSize: 22.0),
                    )),
                Container(
                  alignment: Alignment.bottomRight,
                  child: removeCartFunction == null
                      ? IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.lightBlue[700],
                            size: 30,
                          ),
                          onPressed: () {
                            checkItemInCart(model.title, context);
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () {
                            removeCartFunction();
                            Route route =
                                MaterialPageRoute(builder: (c) => CartPage());
                            Navigator.pushReplacement(context, route);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ));
}

Widget card({Color primaryColor = Colors.white, String imgPath}) {
  return Container(
    height: 150.0,
    width: width * .34,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 5), blurRadius: 10.0, color: Colors.white),
        ]),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Image.network(
        imgPath,
        height: 100.0,
        width: width * .34,
        fit: BoxFit.fill,
      ),
    ),
  );
}

void checkItemInCart(String titleAsID, BuildContext context) {
  HealthApp.sharedPreferences
          .getStringList(HealthApp.userCartList)
          .contains(titleAsID)
      ? Fluttertoast.showToast(msg: "Exercise is already in Favorites.")
      : addItemToCart(titleAsID, context);
}

addItemToCart(String titleAsID, BuildContext context) {
  List tempCartList =
      HealthApp.sharedPreferences.getStringList(HealthApp.userCartList);
  tempCartList.add(titleAsID);

  HealthApp.firestore
      .collection(HealthApp.collectionUser)
      .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
      .updateData({
    HealthApp.userCartList: tempCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Exercise Added to Exercise Successfully.");

    HealthApp.sharedPreferences
        .setStringList(HealthApp.userCartList, tempCartList);

    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}

beginBuildingCart() {
  return SliverToBoxAdapter(
    child: Card(
      color: Colors.white,
      child: Container(
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.insert_emoticon,
              color: Colors.lightBlue[700],
            ),
            Text("Exercise Favorite is empty.",
                style: TextStyle(color: Colors.lightBlue[700])),
          ],
        ),
      ),
    ),
  );
}

removeItemFromUserCart(String shortInfoAsID, BuildContext context) {
  List tempCartList =
      HealthApp.sharedPreferences.getStringList(HealthApp.userCartList);
  tempCartList.remove(shortInfoAsID);

  HealthApp.firestore
      .collection(HealthApp.collectionUser)
      .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
      .updateData({
    HealthApp.userCartList: tempCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Exercise Remove Successfully.");

    HealthApp.sharedPreferences
        .setStringList(HealthApp.userCartList, tempCartList);

    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}
