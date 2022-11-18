import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';

import 'package:flutter_appcovidhealth2/counter/itemcounter.dart';
import 'package:flutter_appcovidhealth2/counter/totalMoney.dart';
import 'package:flutter_appcovidhealth2/widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/widgets/loadWidget.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appcovidhealth2/Models/item.dart';
import 'Exercise.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
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
          "Favorite Exercise",
          style: TextStyle(
              fontSize: 40.0,
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(
              builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Favorite Exercise",
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
                .collection("exercises")
                .where("title",
                    whereIn: HealthApp.sharedPreferences
                        .getStringList(HealthApp.userCartList))
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
                              ItemModel model = ItemModel.fromJson(
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
                                  Provider.of<TotalAmount>(context,
                                          listen: false)
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
              Text("Exercise Favorites is empty."),
            ],
          ),
        ),
      ),
    );
  }

  removeItemFromUserCart(String shortInfoAsId) {
    List tempCartList =
        HealthApp.sharedPreferences.getStringList(HealthApp.userCartList);
    tempCartList.remove(shortInfoAsId);

    HealthApp.firestore
        .collection(HealthApp.collectionUser)
        .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
        .updateData({
      HealthApp.userCartList: tempCartList,
    }).then((v) {
      Fluttertoast.showToast(msg: "Item Removed Successfully.");

      HealthApp.sharedPreferences
          .setStringList(HealthApp.userCartList, tempCartList);

      Provider.of<CartItemCounter>(context, listen: false).displayResult();

      totalAmount = 0;
    });
  }
}
