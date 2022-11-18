import 'dart:async';

import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Home/snackfav.dart';
import 'package:flutter_appcovidhealth2/Models/snackmodel.dart';
import 'package:flutter_appcovidhealth2/counter/snackconter.dart';
import 'package:flutter_appcovidhealth2/widgets/snacksearchbox.dart';
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
import 'SnackPage.dart';
import 'foodfav.dart';

double width;

class FoodSnack extends StatefulWidget {
  @override
  _FoodSnackState createState() => _FoodSnackState();
}

class _FoodSnackState extends State<FoodSnack> {
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
            "Snack TIme",
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
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "Go to Favorites",
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
            Route route = MaterialPageRoute(builder: (c) => SnackFav());
            Navigator.pushReplacement(context, route);
          },
        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                pinned: true, delegate: SnackSearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Snack")
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
                          SnackModel model = SnackModel.fromJson(
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
    );
  }
}

Widget sourceInfo(SnackModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route route =
          MaterialPageRoute(builder: (c) => SnackPage(snackModel: model));
      Navigator.pushReplacement(context, route);
    },
    splashColor: Colors.lightBlue[700],
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
        height: 190.0,
        width: width,
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
                  model.classification,
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
                            MaterialPageRoute(builder: (c) => FoodFav());
                        Navigator.pushReplacement(context, route);
                      },
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
          .getStringList(HealthApp.userSnackCartList)
          .contains(titleAsID)
      ? Fluttertoast.showToast(msg: "Menu is already in Favorites.")
      : addItemToCart(titleAsID, context);
}

addItemToCart(String titleAsID, BuildContext context) {
  List tempCartList =
      HealthApp.sharedPreferences.getStringList(HealthApp.userSnackCartList);
  tempCartList.add(titleAsID);

  HealthApp.firestore
      .collection(HealthApp.collectionUser)
      .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
      .updateData({
    HealthApp.userSnackCartList: tempCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Menu Added to Favorites Successfully.");

    HealthApp.sharedPreferences
        .setStringList(HealthApp.userSnackCartList, tempCartList);

    Provider.of<SnackCounter>(context, listen: false).displayResult();
  });
}
