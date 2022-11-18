import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appcovidhealth2/Authen/register.dart';
import 'package:flutter_appcovidhealth2/Home/homemenu.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class GuideScreen extends StatelessWidget {
  /*here we have a list of OnbordingScreen which we want to have, each OnbordingScreen have a imagePath,title and an desc.
      */
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key key}) : super(key: key);

  void _onIntroEnd(context) {
    Route route = MaterialPageRoute(builder: (_) => HomeApp());
    Navigator.pushReplacement(context, route);
  }

  void _onIntroSkip(context) {
    Route route = MaterialPageRoute(builder: (_) => HomeApp());
    Navigator.pushReplacement(context, route);
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('images/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _buildImage23(String assetName) {
    return Align(
      child: Column(children: [
        SizedBox(
          height: 50,
        ),
        Container(
          child: Image.asset(
            'images/$assetName.png',
            width: 350,
          ),
          alignment: Alignment.bottomCenter,
        ),
      ]),
    );
  }

  Widget _buildImagejpg(String assetName) {
    return Align(
      child: Column(children: [
        SizedBox(
          height: 50,
        ),
        Container(
          child: Image.asset(
            'images/$assetName.jpg',
            width: 350,
            height: 700,
          ),
          alignment: Alignment.bottomCenter,
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome To CovidHealthTech",
          body: "",
          image: _buildImage('logo1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'images/page1.png',
                  width: 350,
                  height: 700,
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'images/appbar.jpg',
                  width: 350,
                  height: 700,
                ),
              ),
              Text("In the app from the last slide it", style: bodyStyle),
              Text("show you the pages to navigate through our application",
                  style: bodyStyle),
              Text(" and also show youe profile picture", style: bodyStyle),
              Text("and username which can be changeed in profile page.",
                  style: bodyStyle),
            ],
          ),
        ),
        PageViewModel(
          title: "Enjoy!!",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [],
          ),
          image: _buildImage('img1'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroSkip(
          context), //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
