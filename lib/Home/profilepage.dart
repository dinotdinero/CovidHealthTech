import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Dialog/ErroDial.dart';
import 'package:flutter_appcovidhealth2/Dialog/alertDial.dart';
import 'package:flutter_appcovidhealth2/widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/widgets/customT.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String userImageUrl = "";
  final formKey = GlobalKey<FormState>();
  File _imageFile;
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  final TextEditingController username = TextEditingController();
  final TextEditingController wieght = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController email = TextEditingController();
  @override
  void initState() {
    username.text = HealthApp.sharedPreferences.getString(HealthApp.userName);
    wieght.text = HealthApp.sharedPreferences.getString(HealthApp.userWeight);
    height.text = HealthApp.sharedPreferences.getString(HealthApp.userHeight);
    email.text = HealthApp.sharedPreferences.getString(HealthApp.userEmail);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.lightBlue[700]),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
        ),
        title: Text(
          "Profile Page",
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
                                'images/profile (1).jpg',
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 50.0,
              ),
              InkWell(
                onTap: _selectAndPickImage,
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlue[700],
                  radius: 90.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        _imageFile == null ? null : FileImage(_imageFile),
                    child: _imageFile == null
                        ? Icon(
                            Icons.add_photo_alternate,
                            size: _screenWidth * 0.15,
                            color: Colors.grey,
                          )
                        : null,
                    radius: 85.0,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  left: 5,
                                ),
                                child: Text(
                                  "Username:",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                )),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusColor: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              controller: username,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(
                                left: 5,
                              ),
                              child: Text(
                                "User E-mail:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusColor: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              controller: email,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  left: 5,
                                ),
                                child: Text(
                                  "Weight(kg):",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                )),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusColor: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              controller: wieght,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(
                                  left: 5,
                                ),
                                child: Text(
                                  "Height(cm):",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                )),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusColor: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              controller: height,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                onPressed: () {
                  uploadAndSaveImage().then((value) {
                    Fluttertoast.showToast(
                        msg:
                            "Changes has been made, Please wait a couple of second to apply changes");
                  });
                },
                color: Colors.lightBlue[700],
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = _imageFile;
    });
  }

  Future<void> uploadAndSaveImage() async {
    uploadToStorage();
  }

  uploadToStorage() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;
      saveUserInfoToFireStore();
    }).whenComplete(() => print("Upload Successfully"));
  }

  Future saveUserInfoToFireStore() async {
    HealthApp.firestore
        .collection(HealthApp.collectionUser)
        .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
        .updateData({
      "url": userImageUrl,
      "name": username.text,
      "weight": int.parse(wieght.text),
      "height": int.parse(height.text),
    });

    await HealthApp.sharedPreferences
        .setString(HealthApp.userAvatarUrl, userImageUrl);
    await HealthApp.sharedPreferences
        .setString(HealthApp.userName, username.text);
    await HealthApp.sharedPreferences
        .setString(HealthApp.userAvatarUrl, userImageUrl);
    await HealthApp.sharedPreferences
        .setString(HealthApp.userName, username.text);
    await HealthApp.sharedPreferences
        .setString(HealthApp.userHeight, height.text);
    await HealthApp.sharedPreferences
        .setString(HealthApp.userWeight, wieght.text);
    HealthApp.user.reload();
    HealthApp.sharedPreferences.reload();
  }
}
