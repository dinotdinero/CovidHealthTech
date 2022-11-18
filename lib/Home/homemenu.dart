import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Home/mointoringhome.dart';
import 'package:flutter_appcovidhealth2/counter/itemcounter.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'carousel.dart';

class HomeApp extends StatefulWidget {
  @override
  _Homestate createState() => _Homestate();
}

class _Homestate extends State<HomeApp> {
  DateTime backButtonPressed;
  int _currentIndex = 0;
  List cardList = [
    Item1(),
    Item2(),
    Item3(),
    Item4(),
    Item5(),
    Item6(),
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
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
            "Home",
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
                                child: Image.asset(
                                  'images/hoomemenu.png',
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: CarouselSlider(
                        height: 400.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: Duration(seconds: 10),
                        aspectRatio: 2.0,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        items: cardList.map((card) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                color: Colors.blueAccent,
                                child: card,
                              ),
                            );
                          });
                        }).toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map<Widget>(cardList, (index, url) {
                        return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.blueAccent
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: MonitoringHome(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 140,
                width: 300,
                child: Text(
                    "You are braver than you believe, stronger than you seem, smarter than you think, and loved more than you’ll ever know — A.A. Milne",
                    style: TextStyle(
                        color: Colors.lightBlue[700],
                        fontSize: 26.0,
                        fontFamily: "Signatra")),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              0.3,
              1
            ],
            colors: [
              Color(0xffff4000),
              Color(0xffffcc66),
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Covid Health Tips",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1],
              colors: [Color(0xff5f2c82), Color(0xff49a09d)]),
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  "Monitor your symptoms and stay in touch with your doctor if you feel worse.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              Text("Tip #1",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ));
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: 300,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Clean and disinfect objects and surfaces that you touch.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              Text("Tip #2",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ));
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1],
              colors: [Colors.green, Color(0xff49a09d)]),
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  "Talking with loved ones while in isolation can help reduce the anxiety and instances of feeling down",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              Text("tip #3",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ));
  }
}

class Item5 extends StatelessWidget {
  const Item5({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1],
              colors: [Colors.yellow[800], Colors.purple]),
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Eat healthy meals and stay hydrated.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              Text("Tip #4",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ));
  }
}

class Item6 extends StatelessWidget {
  const Item6({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1],
              colors: [Colors.blue, Colors.pink[900]]),
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Take breaks from Covid-19 news, including social media.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              Text("Tip #5",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ));
  }
}
