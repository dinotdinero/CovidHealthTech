import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Models/lunchmodel.dart';
import 'package:flutter_appcovidhealth2/counter/TotalLunch.dart';
import 'package:flutter_appcovidhealth2/counter/lunchcounter.dart';


import 'package:flutter_appcovidhealth2/widgets/loadWidget.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'foodlunch.dart';

class LunchFav extends StatefulWidget {
  @override
  _LunchFavState createState() => _LunchFavState();
}

class _LunchFavState extends State<LunchFav> {
  double totalAmount;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalLunch>(context, listen: false).display(0);
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
          "Favorite Lunch",
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
            child: Consumer2<TotalLunch, LunchCounter>(
              builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Favorite Lunch",
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
                .collection("Lunch")
                .where("title",
                    whereIn: HealthApp.sharedPreferences
                        .getStringList(HealthApp.userLunchCartList))
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
                              LunchModel model = LunchModel.fromJson(
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
                                  Provider.of<TotalLunch>(context,
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
              Text("Menu Favorites is empty."),
            ],
          ),
        ),
      ),
    );
  }

  removeItemFromUserCart(String shortInfoAsId) {
    List tempCartList =
        HealthApp.sharedPreferences.getStringList(HealthApp.userLunchCartList);
    tempCartList.remove(shortInfoAsId);

    HealthApp.firestore
        .collection(HealthApp.collectionUser)
        .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
        .updateData({
      HealthApp.userLunchCartList: tempCartList,
    }).then((v) {
      Fluttertoast.showToast(msg: "Menu Removed Successfully.");

      HealthApp.sharedPreferences
          .setStringList(HealthApp.userLunchCartList, tempCartList);

      Provider.of<LunchCounter>(context, listen: false).displayResult();

      totalAmount = 0;
    });
  }
}
