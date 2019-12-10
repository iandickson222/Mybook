import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybook/loading.dart';

class DisplayName extends StatefulWidget 
{
  DisplayName({this.firebaseUser});
  final FirebaseUser firebaseUser;
  
  @override
  _DisplayNameState createState() => _DisplayNameState();
}

class _DisplayNameState extends State<DisplayName> 
{
  String _name;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) 
  {
    if(isLoading == true)
    {
      return Loading();
    }

    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Change Name"),
        actions: <Widget>
        [
         IconButton
         (
           onPressed: () async
           {
             setState(() {
               isLoading = true;
             });

             UserUpdateInfo userUpdateInfo = UserUpdateInfo();
             userUpdateInfo.displayName = _name;
             await widget.firebaseUser.updateProfile(userUpdateInfo);

             setState(() {
               isLoading = false;
             });

             Navigator.pop(context);
           },
           icon: Icon(Icons.check),
         ) 
        ],
      ),

      body: Padding
      (
        padding: const EdgeInsets.all(20.0),
        child: ListView
        (
          children: <Widget>
          [
            TextField
            (
              onChanged: (text) => _name = text,
              decoration: InputDecoration
              (
                labelText: "Name"
              ),
            ),
          ],
          
        ),
      )
    );
  }
}