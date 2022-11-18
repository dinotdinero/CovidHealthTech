import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/Monitoring/viewpage.dart';
import 'package:flutter_appcovidhealth2/widgets/monitoringsearch.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Models/monitoring.dart';
import 'package:flutter_appcovidhealth2/counter/changeMonitoring.dart';
import 'package:flutter_appcovidhealth2/widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/widgets/loadWidget.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:flutter_appcovidhealth2/widgets/wbutton2.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'addmonitor.dart';

class Monitoring extends StatefulWidget {
  final double totalAmount;
  const Monitoring({Key key, this.totalAmount}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Monitoring> {
  DateTime backButtonPressed;

  @override
  Widget build(BuildContext context) {
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
            "Monitoring",
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
                                  'images/diary2.png',
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.lightBlue[700],
              Colors.white,
            ],
          )),
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                  pinned: true, delegate: MonitoringSearchBoxDelegate()),
              StreamBuilder<QuerySnapshot>(
                stream: HealthApp.firestore
                    .collection(HealthApp.collectionUser)
                    .document(HealthApp.sharedPreferences
                        .getString(HealthApp.userUID))
                    .collection(HealthApp.subCollectionMonitoring)
                    .orderBy("day", descending: true)
                    .snapshots(),
                builder: (context, dataSnapshot) {
                  return !dataSnapshot.hasData
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: circularProgress(),
                          ),
                        )
                      : dataSnapshot.data.documents.length == 0
                          ? beginBuildingCart()
                          : SliverStaggeredGrid.countBuilder(
                              crossAxisCount: 1,
                              staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                              itemBuilder: (context, index) {
                                MonitoringModel model =
                                    MonitoringModel.fromJson(dataSnapshot
                                        .data.documents[index].data);
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
            "Add New Monitoring",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.lightBlue[700],
          icon: Icon(
            Icons.medical_services,
            color: Colors.white,
          ),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => AddMonitoring());
            Navigator.pushReplacement(context, route);
          },
        ),
      ),
    );
  }
}

beginBuildingCart() {
  return SliverToBoxAdapter(
    child: Card(
      color: Colors.grey[200],
      child: Container(
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.insert_emoticon,
              color: Colors.white,
            ),
            Text("Monitoring is Empty"),
            Text("Please Create a Monitoring"),
          ],
        ),
      ),
    ),
  );
}

Widget sourceInfo(MonitoringModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  double screenWidth = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: () {
      Route route = MaterialPageRoute(
          builder: (c) => ViewMonitoring(monitoringModel: model));
      Navigator.pushReplacement(context, route);
    },
    splashColor: Colors.lightBlue[700],
    child: Card(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: screenWidth * 0.8,
                    child: Table(
                      children: [
                        TableRow(children: [
                          KeyText(
                            msg: "Day:",
                          ),
                          Text((model.day).toString()),
                        ]),
                        TableRow(children: [
                          KeyText(
                            msg: "Date:",
                          ),
                          Text((model.publishedDate).toDate().toString()),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    await MonitoringModel.deleteItem(
                      monitoringId: model.monitoringId,
                    );
                  },
                ),
              )
            ],
          ),
          Container(),
        ],
      ),
    ),
  );
}

class KeyText extends StatelessWidget {
  final String msg;

  KeyText({Key key, this.msg, IconData image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
