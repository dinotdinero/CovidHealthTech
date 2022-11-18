import 'dart:io';

import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Home/ttodo.dart';
import 'package:flutter_appcovidhealth2/Widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/Models/todo model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddTodo extends StatefulWidget {
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String diaryId = DateTime.now().millisecondsSinceEpoch.toString();
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController titleEdit = TextEditingController();
  final TextEditingController contentEdit = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File _imageFile;
  String userImageUrl = "";
  @override
  Widget build(BuildContext context) {
    HealthApp.userDiary = diaryId;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.lightBlue[700]),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
          ),
          title: Text(
            "Add Diary",
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
                                child: Image.asset(
                                  'images/addmonitor.png',
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            uploadAndSaveImage();
            Route route = MaterialPageRoute(builder: (_) => TodoApp());
            Navigator.pushReplacement(context, route);
          },
          label: Text(
            "Done",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightBlue[700],
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Image:",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Center(
                      child: Container(
                          height: 300,
                          width: 300,
                          child: Align(
                            alignment: Alignment.center,
                            child: _imageFile == null
                                ? Text('No image selected.')
                                : Image.file(_imageFile),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.camera,
                          size: 30.0,
                        ),
                        onPressed: () {
                          _selectAndPickImage();
                        },
                      ),
                    ),
                  ],
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: title,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          minLines: 5,
                          maxLines: 100,
                          controller: content,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
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
      ),
    );
  }

  Future _selectAndPickImage() async {
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
        .collection(HealthApp.subCollectionDiary)
        .document(diaryId)
        .setData({
      "url": userImageUrl,
      "diaryId": diaryId,
      "title": title.text,
      "story": content.text.trim(),
      "publishedDate": DateTime.now(),
    });
  }
}
