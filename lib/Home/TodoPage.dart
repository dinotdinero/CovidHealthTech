import 'dart:io';

import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Home/ttodo.dart';
import 'package:flutter_appcovidhealth2/Widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/Models/todo model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditTodo extends StatefulWidget {
  final DiaryModel diaryModel;
  EditTodo({this.diaryModel});
  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  String diaryId = DateTime.now().millisecondsSinceEpoch.toString();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController titleEdit = TextEditingController();
  final TextEditingController contentEdit = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  File image;

  @override
  void initState() {
    titleEdit.text = widget.diaryModel.title;
    contentEdit.text = widget.diaryModel.story;
    super.initState();
  }

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
            "Edit Diary",
            style: TextStyle(
                fontSize: 55.0,
                color: Colors.lightBlue[700],
                fontFamily: "Signatra"),
          ),
          centerTitle: true,
        ),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            uploadAndSaveImage();
            Route route = MaterialPageRoute(builder: (_) => TodoApp());
            Navigator.pushReplacement(context, route);
          },
          label: Text(
            "Update",
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
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Container(
                                height: 300,
                                width: 300,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: image == null
                                      ? Image.network(widget.diaryModel.url)
                                      : Image.file(image),
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
                      TextField(
                        controller: titleEdit,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
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
                      TextField(
                        controller: contentEdit,
                        minLines: 5,
                        maxLines: 58,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
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
    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = image;
    });
  }

  Future<void> uploadAndSaveImage() async {
    uploadToStorage();
  }

  uploadToStorage() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(image);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;
      saveUserInfoToFireStore(widget.diaryModel.diaryId);
    }).whenComplete(() => print("Upload Successfully"));
  }

  Future saveUserInfoToFireStore(String diaryId) async {
    HealthApp.firestore
        .collection(HealthApp.collectionUser)
        .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
        .collection(HealthApp.subCollectionDiary)
        .document(diaryId)
        .updateData({
      "url": userImageUrl,
      "title": titleEdit.text,
      "story": contentEdit.text.trim(),
    });
  }
}
