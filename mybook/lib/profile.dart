import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybook/displayname.dart';
import 'package:mybook/email.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybook/loading.dart';

class Profile extends StatefulWidget 
{
  Profile({this.firebaseUser});
  final FirebaseUser firebaseUser;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
{
  Future getImage() async 
  {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    Navigator.push(context, MaterialPageRoute(builder: (context) => Loading()));

    if(image != null)
    {
      final StorageReference storageReference = FirebaseStorage().ref().child("${widget.firebaseUser.uid}.jpg");
      final StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.photoUrl = await storageReference.getDownloadURL();
      await widget.firebaseUser.updateProfile(userUpdateInfo);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context)
  {
    return ListView
    (
      children: <Widget>
      [
        Container
        (
          padding: EdgeInsets.all(40.0),
          child: Column
          (
            children: <Widget>
            [
              GestureDetector
              (
                onTap: ()
                {
                  getImage();
                },
                child: CircleAvatar
                (
                  radius: 90.0,
                  backgroundImage: widget.firebaseUser.photoUrl == null ? AssetImage("images/profile_picture.jpg") : NetworkImage(widget.firebaseUser.photoUrl)
                ),
              ),
              SizedBox(height: 20.0),
              ListTile
              (
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayName(firebaseUser: widget.firebaseUser))),
                leading: Icon(Icons.person),
                title: widget.firebaseUser.displayName == null ? Text("Anonymous") : Text(widget.firebaseUser.displayName)
              ),
              ListTile
              (
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Email())),
                leading: Icon(Icons.email),
                title: Text(widget.firebaseUser.email),
              ),
                ListTile
              (
                onTap: (){},
                leading: Icon(Icons.lock),
                title: Text("********"),
              ),
              ListTile
              (
                onTap: () async
                {
                  await FirebaseAuth.instance.signOut();
                },
                leading: Icon(Icons.people),
                title: Text("Sign Out"),
              ),
            ],
          ),
        ),
      ], 
    );
  }
}