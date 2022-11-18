import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appcovidhealth2/Models/snackmodel.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';

import 'foodSnack.dart';

class SnackSearchProduct extends StatefulWidget {
  @override
  _SnackSearchProductState createState() => new _SnackSearchProductState();
}

class _SnackSearchProductState extends State<SnackSearchProduct> {
  Future<QuerySnapshot> docList;

  @override
  Widget build(BuildContext context) {
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
            "Snack Search",
            style: TextStyle(
                fontSize: 40.0,
                color: Colors.lightBlue[700],
                fontFamily: "Signatra"),
          ),
          centerTitle: true,
          bottom: PreferredSize(
              child: searchWidget(), preferredSize: Size(56.0, 56.0)),
        ),
        drawer: MyDrawer(),
        body: FutureBuilder<QuerySnapshot>(
          future: docList,
          builder: (context, snap) {
            return snap.hasData
                ? ListView.builder(
                    itemCount: snap.data.documents.length,
                    itemBuilder: (context, index) {
                      SnackModel model =
                          SnackModel.fromJson(snap.data.documents[index].data);

                      return sourceInfo(model, context);
                    },
                  )
                : Text("No data available.");
          },
        ),
      ),
    );
  }

  Widget searchWidget() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 40.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  onChanged: (value) {
                    startSearching(value);
                  },
                  decoration:
                      InputDecoration.collapsed(hintText: "Search here..."),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future startSearching(String query) async {
    docList = Firestore.instance
        .collection("Snack")
        .where(
          "title",
          isGreaterThanOrEqualTo: query,
        )
        .getDocuments();
  }
}
