import 'package:flutter_appcovidhealth2/Models/item.dart';
import 'package:flutter_appcovidhealth2/widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';

import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  ProductPage({this.itemModel});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantityOfItems = 1;

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
            "Exercise",
            style: TextStyle(
                fontSize: 55.0,
                color: Colors.lightBlue[700],
                fontFamily: "Signatra"),
          ),
          centerTitle: true,
        ),
        drawer: MyDrawer(),
        body: Form(
          child: ListView(
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
                            widget.itemModel.ImageURL,
                            width: 250.0,
                            height: 250,
                          ),
                        ),
                        Container(
                          color: Colors.grey[300],
                          child: SizedBox(
                            height: 2.0,
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
                              "Title:",
                              style: boldTextStyle,
                            ),
                            Text(
                              widget.itemModel.title,
                              style: boldTextStyle,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Repetition:",
                              style: boldTextStyle,
                            ),
                            Text(
                              widget.itemModel.repitition.toString(),
                              style: boldTextStyle,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Instruction:",
                              style: boldTextStyle,
                            ),
                            Text(
                              widget.itemModel.instriction.toString(),
                              style: boldTextStyle,
                            ),
                          ],
                        ),
                      ),
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
}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
