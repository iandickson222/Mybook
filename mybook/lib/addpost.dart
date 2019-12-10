import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class AddPost extends StatefulWidget 
{
  final FirebaseUser firebaseUser;
  AddPost({this.firebaseUser});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> 
{
  String _content;
  File _image;
  String _imageUrl;

  Future getImage() async 
  {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void uploadData() async
  {
    if(_image != null)
    {
      final StorageReference storageReference = FirebaseStorage().ref().child("${DateTime.now()}.jpg");
      final StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      _imageUrl = await storageReference.getDownloadURL(); 
    }

    Firestore.instance.collection("posts").document(DateTime.now().toString()).setData({
      "content": _content,
      "username": widget.firebaseUser.displayName == null ? "Anonymous" : widget.firebaseUser.displayName,
      "image": _imageUrl,
      "avatar": widget.firebaseUser.photoUrl,
      "date": DateFormat.yMMMd("en_US").format(DateTime.now()).toString(),
      "time": DateFormat.jm("en_US").format(DateTime.now()).toString()
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      resizeToAvoidBottomInset: false,
      appBar: AppBar
      (
        title: Text("Add Post"),
        actions: <Widget>
        [
          IconButton
          (
            onPressed: ()
            {
              Navigator.pop(context);
              uploadData();
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Padding
      (
        padding: const EdgeInsets.all(8.0),
        child: ListView
        (
          children: <Widget>
          [
           _image == null ? Container() : Image.file(_image, height: 300.0, fit: BoxFit.contain),
           SizedBox(height: 10.0),
            TextField
            (
              onChanged: (text) => _content = text,
              maxLines: null,
              maxLength: 500,
              textInputAction: TextInputAction.send,
              decoration: InputDecoration
              (
                hintText: "What's on your mind?",
                border: InputBorder.none
                
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton
      (
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}