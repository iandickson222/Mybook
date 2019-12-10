import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybook/addpost.dart';

class Home extends StatefulWidget 
{
  Home({this.firebaseUser});
  final FirebaseUser firebaseUser;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> 
{
  Widget _input()
  {
    return Container
    (
      margin: EdgeInsets.only(bottom: 5.0),
      color: Colors.white,
      child: Column
      (
        children: <Widget>
        [
          SizedBox(height: 10.0),
          ListTile
          (
            leading: CircleAvatar
            (
              backgroundImage: widget.firebaseUser.photoUrl == null ? AssetImage("images/profile_picture.jpg") : NetworkImage(widget.firebaseUser.photoUrl)
            ),
            title: InkWell
            (
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (content) => AddPost(firebaseUser: widget.firebaseUser))),
              child: Container
              (
                alignment: Alignment.centerLeft,
                height: 40.0,

                decoration: BoxDecoration
                (
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding
                (
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text("What's on your mind?"),
                ),
              ),
            )
          ),
          Container
          (
            height: 1.0,
            decoration: BoxDecoration
            (
              color: Colors.grey
            ),
          ),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>
            [
              FlatButton.icon
              (
              label: Text("Live"),
              onPressed: (){},
              icon: Icon(Icons.videocam, color: Colors.red),
              ),
              FlatButton.icon
              (
              label: Text("Photo"),
              onPressed: (){},
              icon: Icon(Icons.photo, color: Colors.green),
              ),
              FlatButton.icon
              (
              label: Text("Check In"),
              onPressed: (){},
              icon: Icon(Icons.location_on, color: Colors.red,),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _post({DocumentSnapshot documentSnapshot})
  {
    return Container
    (
      margin: EdgeInsets.only(bottom: 5.0),
      color: Colors.white,
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>
        [
          ListTile
          (
            leading: CircleAvatar
            (
              backgroundImage: documentSnapshot["avatar"] == null ? AssetImage("images/profile_picture.jpg") : NetworkImage(documentSnapshot["avatar"]),
            ),
            title: Text(documentSnapshot["username"]),
            subtitle: Text("${documentSnapshot["date"]} at ${documentSnapshot["time"]}"),
            trailing: PopupMenuButton<String>
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onSelected: (value){documentSnapshot.reference.delete();},
              icon: Icon(Icons.more_horiz),
              itemBuilder: (BuildContext context)
              {
                return <PopupMenuEntry<String>>
                [
                  PopupMenuItem<String>
                  (
                    value: "",
                    child: Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>
                      [
                        Text("Delete"),
                        Icon(Icons.delete)
                      ],
                    )
                  )
                ];
              },
            )
          ),
          SizedBox(height: 5.0),
          Padding
          (
            padding: const EdgeInsets.only(left: 8.0),
            child: documentSnapshot["content"] == null ? Container() : Text(documentSnapshot["content"]),
          ),
          SizedBox(height: 5.0),
          documentSnapshot["image"] == null ? Container() :
          Image.network
          (
            documentSnapshot["image"],
            height: 300.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 5.0),
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>
            [
              FlatButton.icon
              (
                onPressed: (){},
                label: Text("Like"),
                icon: Icon(Icons.thumb_up),
              ),
              FlatButton.icon
              (
                onPressed: (){},
                label: Text("Comment"),
                icon: Icon(Icons.comment),
              ),
              FlatButton.icon
              (
                onPressed: (){},
                label: Text("Share"),
                icon: Icon(Icons.share),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      color: Colors.grey,
      child: ListView
      (
        primary: true,
        children: <Widget>
        [
          _input(),
          StreamBuilder
          (
            stream: Firestore.instance.collection("posts").snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData ? Container() : ListView.builder
              (
                primary: false,
                shrinkWrap: true,
                reverse: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (content, index)
                {
                  return _post(documentSnapshot: snapshot.data.documents[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}