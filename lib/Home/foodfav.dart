import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Models/food.dart';
import 'package:flutter_appcovidhealth2/Models/item.dart';

import 'package:flutter_appcovidhealth2/counter/fooditemcounter.dart';

import 'package:flutter_appcovidhealth2/counter/TotalFood.dart';
import 'package:flutter_appcovidhealth2/widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/widgets/loadWidget.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'food.dart';

class FoodFav extends StatefulWidget {
  @override
  _FoodFavState createState() => _FoodFavState();
}

class _FoodFavState extends State<FoodFav> {
  double totalAmount;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalFood>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.lightBlue[700]),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
        ),
        title: Text(
          "Favorite Dietary",
          style: TextStyle(
              fontSize: 55.0,
              color: Colors.lightBlue[700],
              fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer2<TotalFood, FoodCounter>(
              builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Favorite Menu",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                );
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: HealthApp.firestore
                .collection("dietary")
                .where("title",
                    whereIn: HealthApp.sharedPreferences
                        .getStringList(HealthApp.userFoodCartList))
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : snapshot.data.documents.length == 0
                      ? beginBuildingCart()
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              FoodModel model = FoodModel.fromJson(
                                  snapshot.data.documents[index].data);

                              if (index == 0) {
                                totalAmount = 0;
                                totalAmount = model.num + totalAmount;
                              } else {
                                totalAmount = model.num + totalAmount;
                              }

                              if (snapshot.data.documents.length - 1 == index) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((t) {
                                  Provider.of<TotalFood>(context, listen: false)
                                      .display(totalAmount);
                                });
                              }

                              return sourceInfo(model, context,
                                  removeCartFunction: () =>
                                      removeItemFromUserCart(model.title));
                            },
                            childCount: snapshot.hasData
                                ? snapshot.data.documents.length
                                : 0,
                          ),
                        );
            },
          ),
        ],
      ),
    );
  }

  beginBuildingCart() {
    return SliverToBoxAdapter(
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Container(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.insert_emoticon,
                color: Colors.white,
              ),
              Text("Menu Favorites is empty."),
            ],
          ),
        ),
      ),
    );
  }

  removeItemFromUserCart(String shortInfoAsId) {
    List tempCartList =
        HealthApp.sharedPreferences.getStringList(HealthApp.userFoodCartList);
    tempCartList.remove(shortInfoAsId);

    HealthApp.firestore
        .collection(HealthApp.collectionUser)
        .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
        .updateData({
      HealthApp.userFoodCartList: tempCartList,
    }).then((v) {
      Fluttertoast.showToast(msg: "Menu Removed Successfully.");

      HealthApp.sharedPreferences
          .setStringList(HealthApp.userFoodCartList, tempCartList);

      Provider.of<FoodCounter>(context, listen: false).displayResult();

      totalAmount = 0;
    });
  }
}
