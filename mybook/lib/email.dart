import 'package:flutter/material.dart';

class Email extends StatefulWidget 
{
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Change Email"),
        actions: <Widget>
        [
         IconButton
         (
           onPressed: () {},
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
              onChanged: (text){},
              decoration: InputDecoration
              (
                labelText: "Email"
              ),
            ),
            TextField
            (
              onChanged: (text) {},
              decoration: InputDecoration
              (
                labelText: "Confirm Email"
              ),
            )
          ],
        ),
      )
    );   
  }
}