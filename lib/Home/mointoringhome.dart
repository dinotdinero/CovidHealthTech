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
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class MonitoringHome extends StatefulWidget {
  final double totalAmount;
  const MonitoringHome({Key key, this.totalAmount}) : super(key: key);

  @override
  _MonitoringHomeState createState() => _MonitoringHomeState();
}

class _MonitoringHomeState extends State<MonitoringHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<MonitoringChanger>(builder: (context, monitoring, c) {
              return Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: HealthApp.firestore
                      .collection(HealthApp.collectionUser)
                      .document(HealthApp.sharedPreferences
                          .getString(HealthApp.userUID))
                      .collection(HealthApp.subCollectionMonitoring)
                      .limit(1)
                      .orderBy("day", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: circularProgress(),
                          )
                        : snapshot.data.documents.length == 0
                            ? noMonitoringCard()
                            : ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return MonitoringCard(
                                    currentIndex: monitoring.counter,
                                    value: index,
                                    MonitoringId: snapshot
                                        .data.documents[index].documentID,
                                    totalAmount: widget.totalAmount,
                                    model: MonitoringModel.fromJson(
                                        snapshot.data.documents[index].data),
                                  );
                                },
                              );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  noMonitoringCard() {
    return Card(
      color: Colors.white,
      child: Container(
        height: 100.0,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_location,
              color: Colors.lightBlue[700],
            ),
            Text(
              "No Monitoring has been saved.",
              style: TextStyle(
                color: Colors.lightBlue[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonitoringCard extends StatefulWidget {
  final MonitoringModel model;
  final String MonitoringId;
  final double totalAmount;
  final int currentIndex;
  final int value;

  MonitoringCard(
      {Key key,
      this.model,
      this.currentIndex,
      this.MonitoringId,
      this.totalAmount,
      this.value})
      : super(key: key);

  @override
  _MonitoringCardState createState() => _MonitoringCardState();
}

class _MonitoringCardState extends State<MonitoringCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Provider.of<MonitoringChanger>(context, listen: false)
            .displayResult(widget.value);
      },
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
                            const Icon(
                              Icons.calendar_view_day,
                              size: 11,
                            ),
                            KeyText(
                              msg: "Day:",
                            ),
                            Text((widget.model.day).toString()),
                          ]),
                          TableRow(children: [
                            const Icon(
                              EvaIcons.thermometerPlus,
                              size: 8,
                            ),
                            KeyText(
                              msg: "Temperature:",
                            ),
                            Text(widget.model.temperature),
                          ]),
                          TableRow(children: [
                            const Icon(
                              Icons.favorite_sharp,
                              size: 11,
                            ),
                            KeyText(
                              msg: "HeartBeat(bpm):",
                            ),
                            Text(widget.model.heartbeat),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}

class KeyText extends StatelessWidget {
  final String msg;

  KeyText({Key key, this.msg}) : super(key: key);

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
